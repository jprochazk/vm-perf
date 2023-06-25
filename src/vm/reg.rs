#![allow(clippy::new_without_default)]

use crate::dispatch::{goto, switch};
use crate::op::{instruction_set, Instruction};

pub struct Thread {
  pub regs: Vec<f64>,
  pub test: bool,
  pub ret: f64,
}

impl Thread {
  pub fn new() -> Self {
    Self {
      regs: vec![0f64; 32],
      test: false,
      ret: 0.0,
    }
  }

  pub fn resize(&mut self, capacity: usize) {
    self.regs.resize(capacity, 0.0)
  }

  #[inline(always)]
  fn op_ldi(&mut self, pc: usize, inst: Instruction) -> usize {
    let args = inst.args.xI();
    self.regs[args.x as usize] = args.I as f64;
    pc + 1
  }

  #[inline(always)]
  fn op_tlt(&mut self, pc: usize, inst: Instruction) -> usize {
    let args = inst.args.abc();
    self.test = self.regs[args.a as usize] < self.regs[args.b as usize];
    pc + 1
  }

  #[inline(always)]
  fn op_jif(&mut self, pc: usize, inst: Instruction) -> usize {
    let args = inst.args.Lb();
    let pc = if !self.test {
      pc + args.L as usize
    } else {
      pc + 1
    };
    self.test = false;
    pc
  }

  #[inline(always)]
  fn op_jl(&mut self, pc: usize, inst: Instruction) -> usize {
    let args = inst.args.Lb();
    pc - args.L as usize
  }

  #[inline(always)]
  fn op_add(&mut self, pc: usize, inst: Instruction) -> usize {
    let args = inst.args.abc();
    self.regs[args.a as usize] = self.regs[args.b as usize] + self.regs[args.c as usize];
    pc + 1
  }

  #[inline(always)]
  fn op_addc(&mut self, pc: usize, inst: Instruction) -> usize {
    let args = inst.args.abc();
    self.regs[args.a as usize] = self.regs[args.b as usize] + args.c as f64;
    pc + 1
  }

  #[inline(always)]
  fn op_mov(&mut self, pc: usize, inst: Instruction) -> usize {
    let args = inst.args.abc();
    self.regs[args.b as usize] = self.regs[args.a as usize];
    pc + 1
  }

  #[inline(always)]
  fn op_ret(&mut self, pc: usize, inst: Instruction) -> usize {
    let args = inst.args.abc();
    self.ret = self.regs[args.a as usize];
    pc + 1
  }
}

/*
ldi #dst, #N
tlt #lhs, #rhs
jif #label
jl #header
add #dst, #lhs, #rhs
addc #dst, #lhs, #n
mov #src, #dst
ret #src
*/

instruction_set! {
  inst(opcode, make) {
    _
    /// no-op
    nop;

    /// `ldi #dst, #N`
    /// ```text,ignore
    /// regs[#dst] = #N
    /// ```
    ldi: xI(dst, N);

    /// `tlt #lhs, #rhs`
    /// ```text,ignore
    /// #lhs < #rhs
    ///
    /// if #lhs < #rhs => set TEST to true
    /// else => set TEST to false
    /// ```
    tlt: abc(lhs, rhs, _c);

    /// `jif #label`
    /// ```text,ignore
    /// jump to #label if TEST is false
    /// ```
    jif: Lb(offset, _b);

    /// `jl #header`
    /// ```text,ignore
    /// jump to #header
    /// ```
    jl: Lb(offset, _b);

    /// `add #dst, #lhs, #rhs`
    /// ```text,ignore
    /// regs[#dst] = regs[#lhs] + regs[#rhs]
    /// ```
    add: abc(dst, lhs, rhs);

    /// `addc #dst, #lhs, #N`
    /// ```text,ignore
    /// regs[#dst] = regs[#lhs] + #N
    /// ```
    addc: abc(dst, lhs, N);

    /// `mov #src, #dst`
    /// ```text,ignore
    /// regs[#dst] = regs[#src]
    /// ```
    mov: abc(src, dst, _c);

    /// `ret #src`
    /// ```text,ignore
    /// set RET to regs[#src]
    /// ```
    ret: abc(src, _b, _c);

    _
    /// `hlt`
    hlt;
  }
}

switch::generate! {
  dispatch_switch(Thread) in inst::opcode {
    _ nop,
    ldi,
    tlt,
    jif,
    jl,
    add,
    addc,
    mov,
    ret,
    _ hlt,
  }
}

goto::generate! {
  gen_jump_table();
  dispatch_goto(Thread) in inst::opcode {
    _ nop,
    ldi,
    tlt,
    jif,
    jl,
    add,
    addc,
    mov,
    ret,
    _ hlt,
  }
}

pub mod fixture {
  use super::*;

  pub fn fib() -> (Vec<Instruction>, usize) {
    /*
      ldi r1, 0
      ldi r2, 1
      ldi r3, 0
    loop:
      tlt r3, r0
      jif end
      add r4, r1, r2
      mov r2, r1
      mov r4, r2
      addc r3, r3, 1
      jl loop
    end:
      ret r1
    */

    use inst::make::*;

    let code = vec![
      ldi(1, 0),
      ldi(2, 1),
      ldi(3, 0),
      // loop:
      tlt(3, 0, 0),
      jif(6, 0),
      add(4, 1, 2),
      mov(2, 1, 0),
      mov(4, 2, 0),
      addc(3, 3, 1),
      jl(6, 0),
      // end:
      ret(1, 0, 0),
      hlt(),
    ];
    let num_regs = 5;

    (code, num_regs)
  }
}

#[cfg(test)]
mod tests {
  use super::*;

  #[test]
  fn test_switch_dispatch() {
    let mut thread = Thread::new();

    let (code, num_regs) = fixture::fib();

    thread.resize(num_regs);
    thread.regs[0] = 20.0; // fib(20)

    dispatch_switch(&mut thread, &code);

    assert_eq!(thread.ret, crate::fib(20));
  }

  #[test]
  fn test_goto_dispatch() {
    let mut thread = Thread::new();

    let (code, num_regs) = fixture::fib();

    thread.resize(num_regs);
    thread.regs[0] = 20.0; // fib(20)

    unsafe { dispatch_goto(&mut thread, &code, 0, &gen_jump_table()) };

    assert_eq!(thread.ret, crate::fib(20));
  }
}
