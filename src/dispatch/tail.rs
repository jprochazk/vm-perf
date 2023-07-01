#[doc(hidden)]
#[macro_export]
macro_rules! __tail_dispatch {
  ($thread:ident, $pc:expr, $inst:ident, $code:ident, $handler_table:ident) => {
    $inst = unsafe { *$code.get_unchecked($pc) };
    let handler = unsafe { $handler_table.get_unchecked($inst.op as usize) };
    return handler($thread, $pc, $inst, $code);
  };
}

#[doc(hidden)]
#[macro_export]
macro_rules! __generate_tail_dispatch_loop {
  (
    $dispatch:ident($thread:ty) in $inst_mod:path {
      _ nop,
      $($inst:ident,)*
      _ hlt,
    }
  ) => {
    type Handler = fn(&mut $thread, usize, Instruction, &[$crate::op::Instruction]) -> Result<()>;

    paste::paste! {
      const HANDLER_TABLE: [Handler; count!(nop $($inst)* hlt)] = [
        op_nop,
        $([<op_ $inst>],)*
        op_hlt,
      ];

      #[allow(unused_mut)]
      #[inline(never)]
      #[no_mangle]
      pub fn $dispatch(thread: &mut $thread, code: &[$crate::op::Instruction]) -> Result<()> {
        let thread = thread;
        let mut pc = 0;
        let mut inst;
        let code = code;
        $crate::__tail_dispatch!(thread, pc, inst, code, HANDLER_TABLE);
      }

      #[allow(unused_assignments)]
      fn op_nop(thread: &mut $thread, mut pc: usize, mut inst: Instruction, code: &[$crate::op::Instruction]) -> Result<()> {
        pc += 1;
        $crate::__tail_dispatch!(thread, pc, inst, code, HANDLER_TABLE);
      }

      $(
        fn [<op_ $inst>](thread: &mut $thread, mut pc: usize, mut inst: Instruction, code: &[$crate::op::Instruction]) -> Result<()> {
          pc = thread.[<op_ $inst>](pc, inst)?;
          $crate::__tail_dispatch!(thread, pc, inst, code, HANDLER_TABLE);
        }
      )*

      #[allow(unused_variables, unused_mut)]
      fn op_hlt(thread: &mut $thread, mut pc: usize, mut inst: Instruction, code: &[$crate::op::Instruction]) -> Result<()> {
        return Ok(());
      }
    }
  };
}

pub use crate::__generate_tail_dispatch_loop as generate;
