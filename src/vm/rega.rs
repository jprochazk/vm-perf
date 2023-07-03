#![allow(clippy::new_without_default)]

/*
- use Enum instead of Instruction args union thing
- remove `self.test = false` from `jif`
- fix loops to use `addc` for increment
*/

use std::str::FromStr;

use rand::rngs::SmallRng;
use rand::{Rng, SeedableRng};

use crate::dispatch::switch;
use crate::nanbox::Value;
use crate::op::{instruction_set, Instruction};
use crate::Result;

#[derive(Debug)]
pub struct Thread {
  pub regs: Vec<Value>,
  pub test: bool,
  pub acc: Value,
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
      regs: vec![Value::none(); 32],
      test: false,
      acc: Value::none(),
      rng: SmallRng::from_seed(get_seed()),
    }
  }

  pub fn resize(&mut self, capacity: usize) {
    self.regs.resize(capacity, Value::none())
  }

  #[inline(always)]
  fn op_ldr(&mut self, pc: usize, inst: Instruction) -> Result<usize> {
    let args = inst.args.Lb();
    self.acc = r!(self, args.L as usize);
    Ok(pc + 1)
  }

  #[inline(always)]
  fn op_str(&mut self, pc: usize, inst: Instruction) -> Result<usize> {
    let args = inst.args.Lb();
    r!(self, args.L as usize) = self.acc;
    Ok(pc + 1)
  }

  #[inline(always)]
  fn op_ldi(&mut self, pc: usize, inst: Instruction) -> Result<usize> {
    let args = inst.args.Ix();
    self.acc = Value::int(args.I as i32);
    Ok(pc + 1)
  }

  #[inline(always)]
  fn op_tlt(&mut self, pc: usize, inst: Instruction) -> Result<usize> {
    let args = inst.args.Lb();
    self.test = r!(self, args.L as usize).op_lt(self.acc);
    Ok(pc + 1)
  }

  #[inline(always)]
  fn op_tne(&mut self, pc: usize, inst: Instruction) -> Result<usize> {
    let args = inst.args.Lb();
    self.test = r!(self, args.L as usize).op_ne(self.acc);
    Ok(pc + 1)
  }

  #[inline(always)]
  fn op_jif(&mut self, pc: usize, inst: Instruction) -> Result<usize> {
    let args = inst.args.Lb();
    let pc = if !self.test {
      pc + args.L as usize
    } else {
      pc + 1
    };
    self.test = false;
    Ok(pc)
  }

  #[inline(always)]
  fn op_jl(&mut self, pc: usize, inst: Instruction) -> Result<usize> {
    let args = inst.args.Lb();
    Ok(pc - args.L as usize)
  }

  #[inline(always)]
  fn op_add(&mut self, pc: usize, inst: Instruction) -> Result<usize> {
    let args = inst.args.Lb();
    self.acc = r!(self, args.L as usize).op_add(self.acc);
    Ok(pc + 1)
  }

  #[inline(always)]
  fn op_addc(&mut self, pc: usize, inst: Instruction) -> Result<usize> {
    let args = inst.args.Ix();
    self.acc = Value::int(args.I as i32).op_add(self.acc);
    Ok(pc + 1)
  }

  #[inline(always)]
  fn op_rnd(&mut self, pc: usize, inst: Instruction) -> Result<usize> {
    let _ = inst;
    self.acc = Value::int(self.rng.gen());
    Ok(pc + 1)
  }

  #[inline(always)]
  fn op_rem(&mut self, pc: usize, inst: Instruction) -> Result<usize> {
    let args = inst.args.Lb();
    self.acc = r!(self, args.L as usize).op_rem(self.acc);
    Ok(pc + 1)
  }

  #[inline(always)]
  fn op_mov(&mut self, pc: usize, inst: Instruction) -> Result<usize> {
    let args = inst.args.abc();
    r!(self, args.b as usize) = r!(self, args.a as usize);
    Ok(pc + 1)
  }

  #[inline(always)]
  fn op_err(&mut self, pc: usize, inst: Instruction) -> Result<usize> {
    let _ = (pc, inst);
    std::hint::black_box(Err("HUH".into()))
  }

  #[inline(always)]
  fn op_ret(&mut self, pc: usize, inst: Instruction) -> Result<usize> {
    let _ = inst;
    Ok(pc + 1)
  }
}

/*
nop
ldr #reg
str #reg
ldi #n
tlt #rhs
tne #rhs
jif #label
jl #header
add #rhs
addc #n
rnd
rem #reg
mov #src, #dst
err
ret
hlt
*/

instruction_set! {
  inst(opcode, make) {
    _ nop;
    ldr: Lb(reg, _b);
    str: Lb(reg, _b);
    ldi: Ix(N, _x);
    tlt: Lb(lhs, _b);
    tne: Lb(lhs, _b);
    jif: Lb(offset, _b);
    jl: Lb(offset, _b);
    add: Lb(lhs, _b);
    addc: Ix(N, _x);
    rnd: abc(_a, _b, _c);
    rem: Lb(lhs, _b);
    mov: abc(src, dst, _b);
    err: abc(_a, _b, _c);
    ret: abc(_a, _b, _c);
    _ hlt;
  }
}

pub mod dispatch {
  use super::*;

  switch::generate! {
    switch(Thread) in inst::opcode {
      _ nop,
      ldr,
      str,
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
      err,
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
    dispatch: fn(&mut Thread, &[Instruction]) -> Result<()>,
  ) -> Thread {
    let (code, setup, assert) = f();
    let mut thread = Thread::new();
    setup(&mut thread);
    dispatch(&mut thread, &code).expect("dispatch failed");
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
      ldi 0
      str r0
      ldi -1
      str r1
      ldi 42
      str r2
    loop:
      ldr r0
      tne r2
      jif .end
      ldr r1
      add r2
      str r2
      jl .loop
    end:
      hlt
    */

    let u = 0; /* unused */
    let r0 = 0;
    let r1 = 1;
    let r2 = 2;

    let code = vec![
      asm::ldi(0, u),
      asm::str(r0, u),
      asm::ldi(-1, u),
      asm::str(r1, u),
      asm::ldi(42, u),
      asm::str(r2, u),
      // loop:
      asm::ldr(r0, u),
      asm::tne(r2, u),
      asm::jif(5, u),
      asm::ldr(r1, u),
      asm::add(r2, u),
      asm::str(r2, u),
      asm::jl(6, u),
      // end:
      asm::hlt(),
    ];

    let setup = |thread: &mut Thread| {
      thread.resize(3);
    };

    let assert = |thread: &Thread| {
      assert!(thread.regs[2].op_eq(Value::int(0)));
    };

    (code, setup, assert)
  }

  pub fn nested_loop() -> (Vec<Instruction>, Setup, Assert) {
    /*
      ldi 0
      str r0
      ldi -1
      str r1
      ldi 10000
      str r2
    outer:
      ldr r0
      tne r2
      jif .outer_end
      ldi 100
      str r3
    inner:
      ldr r0
      tne r3
      jif .inner_end
      ldr r1
      add r3
      str r3
      jl .inner
    .inner_end:
      ldr r1
      add r2
      str r2
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
      asm::ldi(0, u),
      asm::str(r0, u),
      asm::ldi(-1, u),
      asm::str(r1, u),
      asm::ldi(10000, u),
      asm::str(r2, u),
      // outer:
      asm::ldr(r0, u),
      asm::tne(r2, u),
      asm::jif(14, u),
      asm::ldi(100, u),
      asm::str(r3, u),
      // inner:
      asm::ldr(r0, u),
      asm::tne(r3, u),
      asm::jif(5, u),
      asm::ldr(r1, u),
      asm::add(r3, u),
      asm::str(r3, u),
      asm::jl(6, u),
      // inner_end:
      asm::ldr(r1, u),
      asm::add(r2, u),
      asm::str(r2, u),
      asm::jl(15, u),
      // outer_end:
      asm::hlt(),
    ];

    let setup = |thread: &mut Thread| {
      thread.resize(4);
    };

    let assert = |thread: &Thread| {
      assert!(thread.regs[2].op_eq(Value::int(0)));
      assert!(thread.regs[3].op_eq(Value::int(0)));
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
      asm::ldi(0, u),
      asm::str(r0, u),
      asm::ldi(-1, u),
      asm::str(r1, u),
      asm::ldi(10000, u),
      asm::str(r2, u),
      asm::add(r0, u),
      asm::add(r0, u),
      asm::add(r0, u),
      // outer:
      asm::add(r0, u),
      asm::add(r0, u),
      asm::add(r0, u),
      asm::ldr(r0, u),
      asm::tne(r2, u),
      asm::add(r0, u),
      asm::add(r0, u),
      asm::add(r0, u),
      asm::jif(35, u),
      asm::add(r0, u),
      asm::add(r0, u),
      asm::add(r0, u),
      asm::ldi(100, u),
      asm::str(r3, u),
      // inner:
      asm::add(r0, u),
      asm::add(r0, u),
      asm::add(r0, u),
      asm::ldr(r0, u),
      asm::tne(r3, u),
      asm::add(r0, u),
      asm::add(r0, u),
      asm::add(r0, u),
      asm::jif(11, u),
      asm::add(r0, u),
      asm::add(r0, u),
      asm::add(r0, u),
      asm::ldr(r1, u),
      asm::add(r3, u),
      asm::str(r3, u),
      asm::add(r0, u),
      asm::add(r0, u),
      asm::add(r0, u),
      asm::jl(18, u),
      // inner_end:
      asm::add(r0, u),
      asm::add(r0, u),
      asm::add(r0, u),
      asm::ldr(r1, u),
      asm::add(r2, u),
      asm::str(r2, u),
      asm::add(r0, u),
      asm::add(r0, u),
      asm::add(r0, u),
      asm::jl(42, u),
      // outer_end:
      asm::add(r0, u),
      asm::add(r0, u),
      asm::add(r0, u),
      asm::hlt(),
    ];

    let setup = |thread: &mut Thread| {
      thread.resize(4);
    };

    let assert = |thread: &Thread| {
      assert!(thread.regs[2].op_eq(Value::int(0)));
      assert!(thread.regs[3].op_eq(Value::int(0)));
    };

    (code, setup, assert)
  }

  pub fn unpredictable() -> (Vec<Instruction>, Setup, Assert) {
    /*
      ldi 0
      str r0
      ldi -1
      str r1
      ldi 2
      str r2
      ldi 10000
      str r3
    outer:
      ldr r0
      tne r3
      jif .outer_end
      ldi 100
      str r4
    inner:
      ldr r0
      tne r4
      jif .inner_end
      rnd
      str r5
      ldr r2
      rem r5
      tne r0
      jif .skip0
      ldr r1
      add r4
      str r4
    .skip0:
      jl .inner
    .inner_end:
      rnd
      str r4
      ldr r2
      rem r4
      tne r0
      jif .skip1
      ldr r1
      add r3
      str r3
    .skip1:
      jl .outer
    .outer_end:
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
      asm::ldi(0, u),
      asm::str(r0, u),
      asm::ldi(-1, u),
      asm::str(r1, u),
      asm::ldi(2, u),
      asm::str(r2, u),
      asm::ldi(10000, u),
      asm::str(r3, u),
      // outer:
      asm::ldr(r0, u),
      asm::tne(r3, u),
      asm::jif(26, u),
      asm::ldi(100, u),
      asm::str(r4, u),
      // inner:
      asm::ldr(r0, u),
      asm::tne(r4, u),
      asm::jif(11, u),
      asm::rnd(u, u, u),
      asm::str(r5, u),
      asm::ldr(r2, u),
      asm::rem(r5, u),
      asm::tne(r0, u),
      asm::jif(4, u),
      asm::ldr(r1, u),
      asm::add(r4, u),
      asm::str(r4, u),
      // .skip0:
      asm::jl(12, u),
      // .inner_end:
      asm::rnd(u, u, u),
      asm::str(r4, u),
      asm::ldr(r2, u),
      asm::rem(r4, u),
      asm::tne(r0, u),
      asm::jif(4, u),
      asm::ldr(r1, u),
      asm::add(r3, u),
      asm::str(r3, u),
      // .skip1:
      asm::jl(27, u),
      // .outer_end:
      asm::hlt(),
    ];

    let setup = |thread: &mut Thread| {
      thread.resize(6);
    };

    let assert = |thread: &Thread| {
      assert!(thread.regs[3].op_eq(Value::int(0)));
    };

    (code, setup, assert)
  }

  pub fn fib_20() -> (Vec<Instruction>, Setup, Assert) {
    /*
      ldi 0
      str r1
      ldi 1
      str r2
      ldi 0
      str r3
    loop:
      ldr r0
      tlt r3
      jif end
      ldr r2
      add r1
      str r4
      mov r2, r1
      mov r4, r2
      ldr r3
      addc 1
      str r3
      jl loop
    end:
      ldr r1
      ret
      hlt
    */

    let u = 0; /* unused */

    let r0 = 0; /* reserved */
    let r1 = 1;
    let r2 = 2;
    let r3 = 3;
    let r4 = 4;

    let code = vec![
      asm::ldi(0, u),
      asm::str(r1, u),
      asm::ldi(1, u),
      asm::str(r2, u),
      asm::ldi(0, u),
      asm::str(r3, u),
      // loop:
      asm::ldr(r0, u),
      asm::tlt(r3, u),
      asm::jif(10, u),
      asm::ldr(r2, u),
      asm::add(r1, u),
      asm::str(r4, u),
      asm::mov(r2 as u8, r1 as u8, u),
      asm::mov(r4 as u8, r2 as u8, u),
      asm::ldr(r3, u),
      asm::addc(1, u),
      asm::str(r3, u),
      asm::jl(11, u),
      // end:
      asm::ldr(r1, u),
      asm::ret(u, u, u),
      asm::hlt(),
    ];

    let setup = |thread: &mut Thread| {
      thread.resize(5);
      thread.regs[0] = Value::int(20);
    };

    let assert = |thread: &Thread| {
      assert_eq!(thread.acc.to_int().unwrap(), crate::fib(20));
    };

    (code, setup, assert)
  }
}

#[cfg(test)]
mod tests {
  use super::*;

  #[test]
  fn test_fib_20() {
    fixture::run(fixture::fib_20, dispatch::switch);
  }

  #[test]
  fn test_simple_loop() {
    fixture::run(fixture::simple_loop, dispatch::switch);
  }

  #[test]
  fn test_nested_loop() {
    fixture::run(fixture::nested_loop, dispatch::switch);
  }

  #[test]
  fn test_longer_repetitive() {
    fixture::run(fixture::longer_repetitive, dispatch::switch);
  }

  #[test]
  fn test_unpredictable() {
    fixture::run(fixture::unpredictable, dispatch::switch);
  }
}
