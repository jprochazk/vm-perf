#[doc(hidden)]
#[macro_export]
macro_rules! __label_name {
  ($name:expr) => {
    concat!("__goto_", stringify!($name), "__")
  };
}

#[doc(hidden)]
#[macro_export]
macro_rules! __get_label_address {
  ($name:ident) => {
    unsafe {
      let mut addr: usize;
      ::core::arch::asm!(
        concat!("leaq ", $crate::__label_name!($name), "(%rip), {0}"),
        out(reg) addr,
        options(pure, nomem, nostack, att_syntax),
      );
      addr
    }
  };
}

#[doc(hidden)]
#[macro_export]
macro_rules! __dispatch {
  ($thread:ident, $pc:ident, $inst:ident, $code:ident, $jump_table:ident) => {
    let addr = $jump_table[$inst.op as usize];
    unsafe {
      ::core::arch::asm!(
        "jmpq *{0}",
        in(reg) addr,
        in("r8") $thread,
        in("r9") $pc,
        in("r10") ::core::mem::transmute::<_, u32>($inst),
        in("r11") $code as usize,
        in("r12") $jump_table,
        options(nostack, att_syntax),
      );
    }
  }
}

#[doc(hidden)]
#[macro_export]
macro_rules! __dispatch_target {
  ($name:ident($thread:ident, $pc:ident, $inst:ident, $code:ident, $jump_table:ident) $body:block) => {{
    #![allow(unreachable_code, named_asm_labels)]

    unsafe {
      ::core::arch::asm!(
        concat!($crate::__label_name!($name), ":"),
        in("r8") $thread,
        in("r9") $pc,
        in("r10") ::core::mem::transmute::<_, u32>($inst),
        in("r11") $code as usize,
        in("r12") $jump_table,
        options(att_syntax),
      );
    }

    {
      $body
    }

    $inst = transmute($code.add($pc).read());
    $crate::__dispatch!($thread, $pc, $inst, $code, $jump_table);
  }};
}

#[doc(hidden)]
#[macro_export]
macro_rules! __count {
  () => {0};
  ($x:ident) => {1};
  ($x:ident $($xs:ident)*) => {1+$crate::__count!($($xs)*)};
}

#[doc(hidden)]
#[macro_export]
macro_rules! __generate_goto_dispatch_loop {
  (
    $dispatch:ident($thread:ty) in $inst_mod:path where $JumpTable:ident {
      _ nop,
      $($inst:ident,)*
      _ hlt,
    }
  ) => {
    paste::paste! {
      /// # Safety
      /// `code` must be valid:
      /// - jumps may not go out of bounds
      #[inline(never)]
      #[no_mangle]
      pub unsafe fn $dispatch(thread: &mut $thread, code: &[$crate::op::Instruction]) {

        let jump_table = {
          let mut table = [0usize; $crate::__count!(nop $($inst)* hlt)];
          table[$inst_mod::nop as usize] = $crate::__get_label_address!(nop);
          $(
            table[$inst_mod::$inst as usize] = $crate::__get_label_address!($inst);
          )*
          table[$inst_mod::hlt as usize] = $crate::__get_label_address!(hlt);
          table
        };
        let jump_table = &jump_table;

        use ::core::mem::transmute;
        const _: () = {
          let _ = transmute::<u32, $crate::op::Instruction>;
        };

        let code = code as *const _ as *const u32;
        let mut pc = 0usize;
        let mut inst: $crate::op::Instruction = transmute(code.add(pc).read());
        $crate::__dispatch!(thread, pc, inst, code, jump_table);

        $crate::__dispatch_target! {
          nop(thread, pc, inst, code, jump_table) {
            pc += 1;
          }
        };

        $(
          $crate::__dispatch_target! {
            $inst(thread, pc, inst, code, jump_table) {
              pc = thread.[<op_ $inst>](pc, inst);
            }
          }
        )*

        $crate::__dispatch_target! {
          hlt(thread, pc, inst, code, jump_table) {
            return;
          }
        }

        core::hint::unreachable_unchecked()
      }
    }
  };
}

pub use crate::__generate_goto_dispatch_loop as generate;
