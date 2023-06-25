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
        options(att_syntax),
      );
      addr
    }
  };
}

#[doc(hidden)]
#[macro_export]
macro_rules! __label {
  ($name:ident) => {
    unsafe {
      #![allow(named_asm_labels)]
      ::core::arch::asm!(
        concat!($crate::__label_name!($name), ":"),
        options(att_syntax),
      );
    }
  };
}

#[doc(hidden)]
#[macro_export]
macro_rules! __dispatch {
  ($inst:ident, $pc:ident, $jump_table:ident) => {
    let addr = $jump_table[op($inst)];
    unsafe {
      ::core::arch::asm!(
        "jmpq *{0}",
        in(reg) addr,
        in("ecx") $inst,
        in("rdx") $pc,
        options(att_syntax),
      );
    }
  };
}

#[doc(hidden)]
#[macro_export]
macro_rules! __target {
  ($name:ident($inst:ident, $pc:ident, $jump_table:ident) $body:block) => {
    unsafe {
      #![allow(named_asm_labels, unused_assignments)]
      ::core::arch::asm!(
        concat!($crate::__label_name!($name), ":"),
        lateout("ecx") $inst,
        lateout("rdx") $pc,
        options(att_syntax),
      );
    }

    {
      $body
    }

    $crate::__dispatch!($inst, $pc, $jump_table);
  };
}

/* #[doc(hidden)]
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

    $inst = ::core::mem::transmute($code.add($pc).read());
    $crate::__dispatch!($thread, $pc, $inst, $code, $jump_table);
  }};
} */

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
    $gen_jump_table:ident();
    $dispatch:ident($thread:ty) in $inst_mod:path {
      _ nop,
      $($inst:ident,)*
      _ hlt,
    }
  ) => {
    const N: usize = $crate::__count!(nop $($inst)* hlt);

    unsafe fn _op(v: u32) -> usize {
      ::core::mem::transmute::<_, $crate::op::Instruction>(v).op as usize
    }

    pub fn $gen_jump_table() -> [usize; N] {
      use $inst_mod::*;
      let mut table = [0usize; N];
      table[nop as usize] = $crate::__get_label_address!(nop);
      $(
        table[$inst as usize] = $crate::__get_label_address!($inst);
      )*
      table[hlt as usize] = $crate::__get_label_address!(hlt);
      table
    }

    fn to_inst(v: u32) -> $crate::op::Instruction {
      unsafe { ::core::mem::transmute(v) }
    }

    fn op(v: u32) -> usize {
      unsafe { ::core::mem::transmute::<_, $crate::op::Instruction>(v).op as usize }
    }

    paste::paste! {
      /// # Safety
      /// `code` must be valid:
      /// - jumps may not go out of bounds
      #[inline(never)]
      #[no_mangle]
      pub unsafe fn $dispatch(thread: &mut $thread, code: &[$crate::op::Instruction], pc: usize, jump_table: &[usize; N]) {
        let code = unsafe { ::core::mem::transmute::<_, &[u32]>(code) };
        let mut pc = pc;
        let mut inst = code[pc];

        $crate::__dispatch!(inst, pc, jump_table);

        $crate::__target!(nop(inst, pc, jump_table) {
          pc += 1;
          inst = code[pc];
        });

        $(
          $crate::__target!($inst(inst, pc, jump_table) {
            pc = thread.[<op_ $inst>](pc, to_inst(inst));
            inst = code[pc];
          });
        )*

        $crate::__label!(hlt);
        return;
      }
    }

    const _: () = {
      let _ = ::core::mem::transmute::<u32, $crate::op::Instruction>;
    };
  };
}

pub use crate::__generate_goto_dispatch_loop as generate;
