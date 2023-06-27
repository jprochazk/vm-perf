#[doc(hidden)]
#[macro_export]
macro_rules! __label_name {
  ($name:expr) => {
    concat!("__goto_", stringify!($name), "__")
  };
}

#[doc(hidden)]
#[macro_export]
#[cfg(target_arch = "x86_64")]
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
#[cfg(target_arch = "x86_64")]
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
#[cfg(target_arch = "x86_64")]
macro_rules! __dispatch {
  ($thread:ident, $inst:ident, $pc:ident, $jump_table:ident) => {
    let addr = $jump_table[op($inst)];
    unsafe {
      #![allow(unused_assignments)]
      ::core::arch::asm!(
        "jmpq *{0}",
        in(reg) addr,
        in("r8") $thread,
        in("ecx") $inst,
        in("rdx") $pc,
        options(att_syntax),
      );
    }
  };
}

#[doc(hidden)]
#[macro_export]
#[cfg(target_arch = "x86_64")]
macro_rules! __target {
  ($name:ident($thread:ident, $inst:ident, $pc:ident, $jump_table:ident) $body:block) => {
    unsafe {
      #![allow(named_asm_labels, unused_assignments)]
      ::core::arch::asm!(
        concat!($crate::__label_name!($name), ":"),
        lateout("r8") $thread,
        lateout("ecx") $inst,
        lateout("rdx") $pc,
        options(att_syntax),
      );
    }

    {
      $body
    }

    $crate::__dispatch!($thread, $inst, $pc, $jump_table);
  };
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
    const N: usize = count!(nop $($inst)* hlt);

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
        let mut thread = thread as *mut $thread;
        let mut pc = pc;
        let mut inst = code[pc];

        $crate::__dispatch!(thread, inst, pc, jump_table);

        $crate::__target!(nop(thread, inst, pc, jump_table) {
          pc += 1;
          inst = code[pc];
        });

        $(
          $crate::__target!($inst(thread, inst, pc, jump_table) {
            pc = (*thread).[<op_ $inst>](pc, to_inst(inst));
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
