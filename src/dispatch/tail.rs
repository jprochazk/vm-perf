#[doc(hidden)]
#[macro_export]
macro_rules! __tail_dispatch {
  ($thread:ident, $next_pc:expr, $code:ident, $handler_table:ident) => {
    let next_pc = $next_pc;
    let inst = unsafe { *$code.get_unchecked(next_pc) };
    let handler = unsafe { $handler_table.get_unchecked(inst.op as usize) };
    return handler($thread, next_pc, inst, $code);
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
    type Handler = fn(&mut $thread, usize, Instruction, &[$crate::op::Instruction]);

    paste::paste! {
      pub fn $dispatch(thread: &mut $thread, code: &[$crate::op::Instruction]) {
        const HANDLER_TABLE: [Handler; count!(nop $($inst)* hlt)] = [
          op_nop,
          $([<op_ $inst>],)*
          op_hlt,
        ];

        fn op_nop(thread: &mut $thread, pc: usize, inst: Instruction, code: &[$crate::op::Instruction]) {
          let _ = inst;
          $crate::__tail_dispatch!(thread, pc + 1, code, HANDLER_TABLE);
        }

        $(
          fn [<op_ $inst>](thread: &mut $thread, pc: usize, inst: Instruction, code: &[$crate::op::Instruction]) {
            let next_pc = thread.[<op_ $inst>](pc, inst);
            $crate::__tail_dispatch!(thread, next_pc, code, HANDLER_TABLE);
          }
        )*

        fn op_hlt(thread: &mut $thread, pc: usize, inst: Instruction, code: &[$crate::op::Instruction]) {
          let _ = (thread, pc, inst, code);
          return;
        }

        $crate::__tail_dispatch!(thread, 0, code, HANDLER_TABLE);
      }
    }
  };
}

pub use crate::__generate_tail_dispatch_loop as generate;
