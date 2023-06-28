#![allow(clippy::new_without_default)]

use std::str::FromStr;

use rand::rngs::SmallRng;
use rand::{Rng, SeedableRng};

use crate::dispatch::{goto, switch, tail};
use crate::op::{instruction_set, Instruction};

pub struct Thread {
  pub regs: Vec<i32>,
  pub test: bool,
  pub ret: i32,
  pub rng: SmallRng,
}

macro_rules! r {
  ($self:ident, $i:expr) => {
    *unsafe { $self.regs.get_unchecked_mut($i) }
  };
}

fn get_seed() -> [u8; 32] {
  let mut seed = [0u8; 32];

  for (i, v) in include_str!("seed.txt")
    .split(',')
    .flat_map(<u8 as FromStr>::from_str)
    .enumerate()
  {
    seed[i] = v;
  }

  seed
}

impl Thread {
  pub fn new() -> Self {
    Self {
      regs: vec![0; 32],
      test: false,
      ret: 0,
      rng: SmallRng::from_seed(get_seed()),
    }
  }

  pub fn resize(&mut self, capacity: usize) {
    self.regs.resize(capacity, 0)
  }

  #[inline(always)]
  fn op_ldi(&mut self, pc: usize, inst: Instruction) -> usize {
    let args = inst.args.xI();
    r!(self, args.x as usize) = args.I as i32;
    pc + 1
  }

  #[inline(always)]
  fn op_tlt(&mut self, pc: usize, inst: Instruction) -> usize {
    let args = inst.args.abc();
    self.test = r!(self, args.a as usize) < r!(self, args.b as usize);
    pc + 1
  }

  #[inline(always)]
  fn op_tne(&mut self, pc: usize, inst: Instruction) -> usize {
    let args = inst.args.abc();
    self.test = r!(self, args.a as usize) != r!(self, args.b as usize);
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
    r!(self, args.a as usize) = r!(self, args.b as usize) + r!(self, args.c as usize);
    pc + 1
  }

  #[inline(always)]
  fn op_addc(&mut self, pc: usize, inst: Instruction) -> usize {
    let args = inst.args.abc();
    r!(self, args.a as usize) = r!(self, args.b as usize) + args.c as i32;
    pc + 1
  }

  #[inline(always)]
  fn op_rnd(&mut self, pc: usize, inst: Instruction) -> usize {
    let args = inst.args.abc();
    r!(self, args.a as usize) = self.rng.gen();
    pc + 1
  }

  #[inline(always)]
  fn op_rem(&mut self, pc: usize, inst: Instruction) -> usize {
    let args = inst.args.abc();
    r!(self, args.a as usize) = r!(self, args.b as usize) % r!(self, args.c as usize);
    pc + 1
  }

  #[inline(always)]
  fn op_mov(&mut self, pc: usize, inst: Instruction) -> usize {
    let args = inst.args.abc();
    r!(self, args.b as usize) = r!(self, args.a as usize);
    pc + 1
  }

  #[inline(always)]
  fn op_ret(&mut self, pc: usize, inst: Instruction) -> usize {
    let args = inst.args.abc();
    self.ret = r!(self, args.a as usize);
    pc + 1
  }
}

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

    /// `tne #lhs, #rhs`
    /// ```text,ignore
    /// #lhs == #rhs
    ///
    /// if #lhs != #rhs => set TEST to true
    /// else => set TEST to false
    /// ```
    tne: abc(lhs, rhs, _c);

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

    /// `rnd #dst`
    /// ```text,ignore
    /// regs[#dst] = rand()
    /// ```
    rnd: abc(dst, _b, _c);

    /// `rem #dst, #lhs, #rhs`
    /// ```text,ignore
    /// regs[#dst] = #lhs % #rhs
    /// ```
    rem: abc(dst, _b, _c);

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

pub mod dispatch {
  use super::*;

  switch::generate! {
    switch(Thread) in inst::opcode {
      _ nop,
      ldi,
      tlt,
      tne,
      jif,
      jl,
      add,
      addc,
      rnd,
      rem,
      mov,
      ret,
      _ hlt,
    }
  }

  goto::generate! {
    gen_jump_table();
    goto_inner(Thread) in inst::opcode {
      _ nop,
      ldi,
      tlt,
      tne,
      jif,
      jl,
      add,
      addc,
      rnd,
      rem,
      mov,
      ret,
      _ hlt,
    }
  }

  pub fn goto(thread: &mut Thread, code: &[Instruction]) {
    unsafe { goto_inner(thread, code, 0, &gen_jump_table()) }
  }

  tail::generate! {
    tail(Thread) in inst::opcode {
      _ nop,
      ldi,
      tlt,
      tne,
      jif,
      jl,
      add,
      addc,
      rnd,
      rem,
      mov,
      ret,
      _ hlt,
    }
  }
}

pub mod fixture {
  use inst::make as asm;

  use super::*;

  pub fn run(
    f: fn() -> (Vec<Instruction>, Setup, Assert),
    dispatch: fn(&mut Thread, &[Instruction]),
  ) -> Thread {
    let (code, setup, assert) = f();
    let mut thread = Thread::new();
    setup(&mut thread);
    dispatch(&mut thread, &code);
    assert(&thread);
    thread
  }

  pub type Setup = fn(&mut Thread);

  pub type Assert = fn(&Thread);

  pub struct Fixture {
    pub code: Vec<Instruction>,
    pub setup: Setup,
  }

  pub fn simple_loop() -> (Vec<Instruction>, Setup, Assert) {
    /*
      ldi r0, 0
      ldi r1, -1
      ldi r2, 42
    loop:
      tne r2, r0
      jif .end
      add r2, r2, r1
      jl .loop
    end:
      hlt
    */

    let u = 0; /* unused */
    let r0 = 0;
    let r1 = 1;
    let r2 = 2;

    let code = vec![
      asm::ldi(r0, 0),
      asm::ldi(r1, -1),
      asm::ldi(r2, 42),
      // loop:
      asm::tne(r2, r0, u),
      asm::jif(3, u),
      asm::add(r2, r2, r1),
      asm::jl(3, u),
      // end:
      asm::hlt(),
    ];

    let setup = |thread: &mut Thread| {
      thread.resize(3);
    };

    let assert = |thread: &Thread| {
      assert_eq!(thread.regs[2], 0);
    };

    (code, setup, assert)
  }

  pub fn nested_loop() -> (Vec<Instruction>, Setup, Assert) {
    /*
      ldi r0, 0
      ldi r1, -1
      ldi r2, 10000
    outer:
      tne r2, r0
      jif .outer_end
      ldi r3, 100
    inner:
      tne r3, r0
      jif .inner_end
      add r3, r3, r1
      jl .inner
    .inner_end:
      jl .outer
    .outer_end:
      hlt
    */

    let u = 0; /* unused */
    let r0 = 0;
    let r1 = 1;
    let r2 = 2;
    let r3 = 3;

    let code = vec![
      /*0 */ asm::ldi(r0, 0),
      /*1 */ asm::ldi(r1, -1),
      /*2 */ asm::ldi(r2, 10000),
      // outer:
      /*3 */ asm::tne(r2, r0, u),
      /*4 */ asm::jif(8, u),
      /*5 */ asm::ldi(r3, 100),
      // inner:
      /*6 */ asm::tne(r3, r0, u),
      /*7 */ asm::jif(3, u),
      /*8 */ asm::add(r3, r3, r1),
      /*9 */ asm::jl(3, u),
      // inner_end:
      /*10*/ asm::add(r2, r2, r1),
      /*11*/ asm::jl(8, u),
      // outer_end:
      /*12*/ asm::hlt(),
    ];

    let setup = |thread: &mut Thread| {
      thread.resize(4);
    };

    let assert = |thread: &Thread| {
      assert_eq!(thread.regs[2], 0);
      assert_eq!(thread.regs[3], 0);
    };

    (code, setup, assert)
  }

  pub fn longer_repetitive() -> (Vec<Instruction>, Setup, Assert) {
    let u = 0; /* unused */
    let r0 = 0;
    let r1 = 1;
    let r2 = 2;
    let r3 = 3;

    let code = vec![
      asm::ldi(r0, 0),
      asm::ldi(r1, -1),
      asm::ldi(r2, 10000),
      asm::add(r0, r0, r0),
      asm::add(r3, r3, r0),
      asm::add(r0, r0, r0),
      // outer:
      asm::add(r0, r0, r0),
      asm::add(r3, r3, r0),
      asm::add(r0, r0, r0),
      asm::tne(r2, r0, u),
      asm::add(r0, r0, r0),
      asm::add(r3, r3, r0),
      asm::add(r0, r0, r0),
      asm::jif(29, u),
      asm::add(r0, r0, r0),
      asm::add(r3, r3, r0),
      asm::add(r0, r0, r0),
      asm::ldi(r3, 100),
      // inner:
      asm::add(r0, r0, r0),
      asm::add(r3, r3, r0),
      asm::add(r0, r0, r0),
      asm::tne(r3, r0, u),
      asm::add(r0, r0, r0),
      asm::add(r3, r3, r0),
      asm::add(r0, r0, r0),
      asm::jif(9, u),
      asm::add(r0, r0, r0),
      asm::add(r3, r3, r0),
      asm::add(r0, r0, r0),
      asm::add(r3, r3, r1),
      asm::add(r0, r0, r0),
      asm::add(r3, r3, r0),
      asm::add(r0, r0, r0),
      asm::jl(12, u),
      // inner_end:
      asm::add(r0, r0, r0),
      asm::add(r3, r3, r0),
      asm::add(r0, r0, r0),
      asm::add(r2, r2, r1),
      asm::add(r0, r0, r0),
      asm::add(r3, r3, r0),
      asm::add(r0, r0, r0),
      asm::jl(32, u),
      // outer_end:
      asm::add(r0, r0, r0),
      asm::add(r3, r3, r0),
      asm::add(r0, r0, r0),
      asm::hlt(),
    ];

    let setup = |thread: &mut Thread| {
      thread.resize(4);
    };

    let assert = |thread: &Thread| {
      assert_eq!(thread.regs[2], 0);
      assert_eq!(thread.regs[3], 0);
    };

    (code, setup, assert)
  }

  pub fn unpredictable() -> (Vec<Instruction>, Setup, Assert) {
    /*
      ldi r0, 0
      ldi r1, -1
      ldi r2, 2
      ldi r3, 10000
    outer:
      tne r3, r0
      jif .outer_end
      ldi r4, 100
    inner:
      tne r4, r0
      jif .inner_end
      rnd r5
      rem r5, r5, r2
      tne r5, r0
      jif .skip0
      add r4, r4, r1
    skip0:
      jl .inner
    inner_end:
      rnd r4
      rem r4, r4, r2
      tne r4, r0
      jif .skip1
      add r3, r3, r1
    skip1:
      jl .outer
    outer_end:
      hlt
    */

    let u = 0;
    let r0 = 0;
    let r1 = 1;
    let r2 = 2;
    let r3 = 3;
    let r4 = 4;
    let r5 = 5;

    let code = vec![
      asm::ldi(r0, 0),
      asm::ldi(r1, -1),
      asm::ldi(r2, 2),
      asm::ldi(r3, 10000),
      // outer:
      asm::tne(r3, r0, u),
      asm::jif(16, u),
      asm::ldi(r4, 100),
      // inner:
      asm::tne(r4, r0, u),
      asm::jif(7, u),
      asm::rnd(r5, u, u),
      asm::rem(r5, r5, r2),
      asm::tne(r5, r0, u),
      asm::jif(2, u),
      asm::add(r4, r4, r1),
      // skip0:
      asm::jl(7, u),
      // inner_end:
      asm::rnd(r4, u, u),
      asm::rem(r4, r4, r2),
      asm::tne(r4, r0, u),
      asm::jif(2, u),
      asm::add(r3, r3, r1),
      // skip1:
      asm::jl(16, u),
      // outer_end:
      asm::hlt(),
    ];

    let setup = |thread: &mut Thread| {
      thread.resize(6);
    };

    let assert = |thread: &Thread| {
      assert_eq!(thread.regs[3], 0);
    };

    (code, setup, assert)
  }

  pub fn fib_20() -> (Vec<Instruction>, Setup, Assert) {
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
      hlt
    */

    let u = 0; /* unused */

    let r0 = 0; /* reserved */
    let r1 = 1;
    let r2 = 2;
    let r3 = 3;
    let r4 = 4;

    let code = vec![
      asm::ldi(r1, 0),
      asm::ldi(r2, 1),
      asm::ldi(r3, 0),
      // loop:
      asm::tlt(r3, r0, u),
      asm::jif(6, u),
      asm::add(r4, r1, r2),
      asm::mov(r2, r1, u),
      asm::mov(r4, r2, u),
      asm::addc(r3, r3, 1),
      asm::jl(6, u),
      // end:
      asm::ret(r1, u, u),
      asm::hlt(),
    ];

    let setup = |thread: &mut Thread| {
      thread.resize(5);
      thread.regs[0] = 20;
    };

    let assert = |thread: &Thread| {
      assert_eq!(thread.ret, crate::fib(20));
    };

    (code, setup, assert)
  }
}

#[cfg(test)]
mod tests {
  use super::*;

  type Dispatch<'a> = (&'a str, fn(&mut Thread, &[Instruction]));

  const DISPATCH: &[Dispatch] = &[
    ("switch", dispatch::switch),
    ("goto", dispatch::goto),
    ("tail", dispatch::tail),
  ];

  #[test]
  fn test_fib_20() {
    for (_, dispatch) in DISPATCH {
      fixture::run(fixture::fib_20, *dispatch);
    }
  }

  #[test]
  fn test_simple_loop() {
    for (_, dispatch) in DISPATCH {
      fixture::run(fixture::simple_loop, *dispatch);
    }
  }

  #[test]
  fn test_nested_loop() {
    for (_, dispatch) in DISPATCH {
      fixture::run(fixture::nested_loop, *dispatch);
    }
  }

  #[test]
  fn test_longer_repetitive() {
    for (_, dispatch) in DISPATCH {
      fixture::run(fixture::longer_repetitive, *dispatch);
    }
  }

  #[test]
  fn test_unpredictable() {
    for (_, dispatch) in DISPATCH {
      fixture::run(fixture::unpredictable, *dispatch);
    }
  }
}
