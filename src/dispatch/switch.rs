#[doc(hidden)]
#[macro_export]
macro_rules! __generate_switch_dispatch_loop {
  (
    $dispatch:ident($thread:ty) in $inst_mod:path {
      _ nop,
      $($inst:ident,)*
      _ hlt,
    }
  ) => {
    paste::paste! {
      #[inline(never)]
      #[no_mangle]
      pub fn $dispatch(thread: &mut $thread, code: &[$crate::op::Instruction]) {
        let mut pc = 0;
        loop {
          let inst = code[pc];
          match inst.op {
            $inst_mod::nop => pc += 1,
            $(
              $inst_mod::$inst => pc = thread.[<op_ $inst>](pc, inst),
            )*
            $inst_mod::hlt => break,
            _ => unreachable!(),
          }
        }
      }
    }
  };
}

pub use crate::__generate_switch_dispatch_loop as generate;
