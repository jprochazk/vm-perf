#![allow(clippy::new_without_default)]

use std::str::FromStr;

use rand::rngs::SmallRng;
use rand::{Rng, SeedableRng};

use crate::nanbox::Value;
use crate::Result;

pub struct Thread {
  pub regs: Vec<Value>,
  pub test: bool,
  pub ret: Value,
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
      ret: Value::none(),
      rng: SmallRng::from_seed(get_seed()),
    }
  }

  pub fn resize(&mut self, capacity: usize) {
    self.regs.resize(capacity, Value::none())
  }

  #[inline]
  fn op_load_i(&mut self, pc: usize, dst: u8, n: i16) -> Result<usize> {
    r!(self, dst as usize) = Value::int(n as i32);
    Ok(pc + 1)
  }

  #[inline]
  fn op_test_lt(&mut self, pc: usize, lhs: u8, rhs: u8) -> Result<usize> {
    self.test = r!(self, lhs as usize).op_lt(r!(self, rhs as usize));
    Ok(pc + 1)
  }

  #[inline]
  fn op_test_ne(&mut self, pc: usize, lhs: u8, rhs: u8) -> Result<usize> {
    self.test = r!(self, lhs as usize).op_ne(r!(self, rhs as usize));
    Ok(pc + 1)
  }

  #[inline]
  fn op_jump_if(&mut self, pc: usize, offset: u16) -> Result<usize> {
    let pc = if !self.test {
      pc + offset as usize
    } else {
      pc + 1
    };
    self.test = false;
    Ok(pc)
  }

  #[inline]
  fn op_jump_l(&mut self, pc: usize, offset: u16) -> Result<usize> {
    Ok(pc - offset as usize)
  }

  #[inline]
  fn op_add(&mut self, pc: usize, dst: u8, lhs: u8, rhs: u8) -> Result<usize> {
    r!(self, dst as usize) = r!(self, lhs as usize).op_add(r!(self, rhs as usize));
    Ok(pc + 1)
  }

  #[inline]
  fn op_addc(&mut self, pc: usize, dst: u8, lhs: u8, n: u8) -> Result<usize> {
    r!(self, dst as usize) = r!(self, lhs as usize).op_add(Value::int(n as i32));
    Ok(pc + 1)
  }

  #[inline]
  fn op_random(&mut self, pc: usize, dst: u8) -> Result<usize> {
    r!(self, dst as usize) = Value::int(self.rng.gen::<i32>());
    Ok(pc + 1)
  }

  #[inline]
  fn op_rem(&mut self, pc: usize, dst: u8, lhs: u8, rhs: u8) -> Result<usize> {
    r!(self, dst as usize) = r!(self, lhs as usize).op_rem(r!(self, rhs as usize));
    Ok(pc + 1)
  }

  #[inline]
  fn op_move(&mut self, pc: usize, src: u8, dst: u8) -> Result<usize> {
    r!(self, dst as usize) = r!(self, src as usize);
    Ok(pc + 1)
  }

  #[inline]
  fn op_error(&mut self, _: usize) -> Result<usize> {
    std::hint::black_box(Err("HUH".into()))
  }

  #[inline]
  fn op_return(&mut self, pc: usize, src: u8) -> Result<usize> {
    self.ret = r!(self, src as usize);
    Ok(pc + 1)
  }

  #[inline(never)]
  pub fn dispatch(&mut self, code: &[Instruction]) -> Result<()> {
    let mut pc = 0;
    loop {
      match unsafe { *code.get_unchecked(pc) } {
        Instruction::Nop => pc += 1,
        Instruction::LoadI { dst, n } => pc = self.op_load_i(pc, dst, n)?,
        Instruction::TestLt { lhs, rhs } => pc = self.op_test_lt(pc, lhs, rhs)?,
        Instruction::TestNe { lhs, rhs } => pc = self.op_test_ne(pc, lhs, rhs)?,
        Instruction::JumpIF { offset } => pc = self.op_jump_if(pc, offset)?,
        Instruction::JumpL { offset } => pc = self.op_jump_l(pc, offset)?,
        Instruction::Add { dst, lhs, rhs } => pc = self.op_add(pc, dst, lhs, rhs)?,
        Instruction::Addc { dst, lhs, n } => pc = self.op_addc(pc, dst, lhs, n)?,
        Instruction::Random { dst } => pc = self.op_random(pc, dst)?,
        Instruction::Rem { dst, lhs, rhs } => pc = self.op_rem(pc, dst, lhs, rhs)?,
        Instruction::Move { src, dst } => pc = self.op_move(pc, src, dst)?,
        Instruction::Error => pc = self.op_error(pc)?,
        Instruction::Return { src } => pc = self.op_return(pc, src)?,
        Instruction::Halt => break Ok(()),
      }
    }
  }
}

#[derive(Clone, Copy)]
#[repr(u8)]
pub enum Instruction {
  Nop,
  LoadI { dst: u8, n: i16 },
  TestLt { lhs: u8, rhs: u8 },
  TestNe { lhs: u8, rhs: u8 },
  JumpIF { offset: u16 },
  JumpL { offset: u16 },
  Add { dst: u8, lhs: u8, rhs: u8 },
  Addc { dst: u8, lhs: u8, n: u8 },
  Random { dst: u8 },
  Rem { dst: u8, lhs: u8, rhs: u8 },
  Move { src: u8, dst: u8 },
  Error,
  Return { src: u8 },
  Halt,
}

pub mod fixture {
  use super::*;

  pub fn run(f: fn() -> (Vec<Instruction>, Setup, Assert)) -> Thread {
    let (code, setup, assert) = f();
    let mut thread = Thread::new();
    setup(&mut thread);
    thread.dispatch(&code).expect("dispatch failed");
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
    use Instruction::*;

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

    let r0 = 0;
    let r1 = 1;
    let r2 = 2;

    let code = vec![
      LoadI { dst: r0, n: 0 },
      LoadI { dst: r1, n: -1 },
      LoadI { dst: r2, n: 42 },
      // loop:
      TestNe { lhs: r2, rhs: r0 },
      JumpIF { offset: 3 },
      Add {
        dst: r2,
        lhs: r2,
        rhs: r1,
      },
      JumpL { offset: 3 },
      // end:
      Halt,
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
    use Instruction::*;

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

    let r0 = 0;
    let r1 = 1;
    let r2 = 2;
    let r3 = 3;

    let code = vec![
      LoadI { dst: r0, n: 0 },
      LoadI { dst: r1, n: -1 },
      LoadI { dst: r2, n: 10000 },
      // outer:
      TestNe { lhs: r2, rhs: r0 },
      JumpIF { offset: 8 },
      LoadI { dst: r3, n: 100 },
      // inner:
      TestNe { lhs: r3, rhs: r0 },
      JumpIF { offset: 3 },
      Add {
        dst: r3,
        lhs: r3,
        rhs: r1,
      },
      JumpL { offset: 3 },
      // inner_end:
      Add {
        dst: r2,
        lhs: r2,
        rhs: r1,
      },
      JumpL { offset: 8 },
      // outer_end:
      Halt,
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
    use Instruction::*;

    let r0 = 0;
    let r1 = 1;
    let r2 = 2;
    let r3 = 3;

    let code = vec![
      LoadI { dst: r0, n: 0 },
      LoadI { dst: r1, n: -1 },
      LoadI { dst: r2, n: 10000 },
      LoadI { dst: r3, n: 0 },
      Add {
        dst: r0,
        lhs: r0,
        rhs: r0,
      },
      Add {
        dst: r3,
        lhs: r3,
        rhs: r0,
      },
      Add {
        dst: r0,
        lhs: r0,
        rhs: r0,
      },
      // outer:
      Add {
        dst: r0,
        lhs: r0,
        rhs: r0,
      },
      Add {
        dst: r3,
        lhs: r3,
        rhs: r0,
      },
      Add {
        dst: r0,
        lhs: r0,
        rhs: r0,
      },
      TestNe { lhs: r2, rhs: r0 },
      Add {
        dst: r0,
        lhs: r0,
        rhs: r0,
      },
      Add {
        dst: r3,
        lhs: r3,
        rhs: r0,
      },
      Add {
        dst: r0,
        lhs: r0,
        rhs: r0,
      },
      JumpIF { offset: 29 },
      Add {
        dst: r0,
        lhs: r0,
        rhs: r0,
      },
      Add {
        dst: r3,
        lhs: r3,
        rhs: r0,
      },
      Add {
        dst: r0,
        lhs: r0,
        rhs: r0,
      },
      LoadI { dst: r3, n: 100 },
      // inner:
      Add {
        dst: r0,
        lhs: r0,
        rhs: r0,
      },
      Add {
        dst: r3,
        lhs: r3,
        rhs: r0,
      },
      Add {
        dst: r0,
        lhs: r0,
        rhs: r0,
      },
      TestNe { lhs: r3, rhs: r0 },
      Add {
        dst: r0,
        lhs: r0,
        rhs: r0,
      },
      Add {
        dst: r3,
        lhs: r3,
        rhs: r0,
      },
      Add {
        dst: r0,
        lhs: r0,
        rhs: r0,
      },
      JumpIF { offset: 9 },
      Add {
        dst: r0,
        lhs: r0,
        rhs: r0,
      },
      Add {
        dst: r3,
        lhs: r3,
        rhs: r0,
      },
      Add {
        dst: r0,
        lhs: r0,
        rhs: r0,
      },
      Add {
        dst: r3,
        lhs: r3,
        rhs: r1,
      },
      Add {
        dst: r0,
        lhs: r0,
        rhs: r0,
      },
      Add {
        dst: r3,
        lhs: r3,
        rhs: r0,
      },
      Add {
        dst: r0,
        lhs: r0,
        rhs: r0,
      },
      JumpL { offset: 12 },
      // inner_end:
      Add {
        dst: r0,
        lhs: r0,
        rhs: r0,
      },
      Add {
        dst: r3,
        lhs: r3,
        rhs: r0,
      },
      Add {
        dst: r0,
        lhs: r0,
        rhs: r0,
      },
      Add {
        dst: r2,
        lhs: r2,
        rhs: r1,
      },
      Add {
        dst: r0,
        lhs: r0,
        rhs: r0,
      },
      Add {
        dst: r3,
        lhs: r3,
        rhs: r0,
      },
      Add {
        dst: r0,
        lhs: r0,
        rhs: r0,
      },
      JumpL { offset: 32 },
      // outer_end:
      Add {
        dst: r0,
        lhs: r0,
        rhs: r0,
      },
      Add {
        dst: r3,
        lhs: r3,
        rhs: r0,
      },
      Add {
        dst: r0,
        lhs: r0,
        rhs: r0,
      },
      Halt,
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
    use Instruction::*;

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

    let r0 = 0;
    let r1 = 1;
    let r2 = 2;
    let r3 = 3;
    let r4 = 4;
    let r5 = 5;

    let code = vec![
      LoadI { dst: r0, n: 0 },
      LoadI { dst: r1, n: -1 },
      LoadI { dst: r2, n: 2 },
      LoadI { dst: r3, n: 10000 },
      // outer:
      TestNe { lhs: r3, rhs: r0 },
      JumpIF { offset: 16 },
      LoadI { dst: r4, n: 100 },
      // inner:
      TestNe { lhs: r4, rhs: r0 },
      JumpIF { offset: 7 },
      Random { dst: r5 },
      Rem {
        dst: r5,
        lhs: r5,
        rhs: r2,
      },
      TestNe { lhs: r5, rhs: r0 },
      JumpIF { offset: 2 },
      Add {
        dst: r4,
        lhs: r4,
        rhs: r1,
      },
      // skip0:
      JumpL { offset: 7 },
      // inner_end:
      Random { dst: r4 },
      Rem {
        dst: r4,
        lhs: r4,
        rhs: r2,
      },
      TestNe { lhs: r4, rhs: r0 },
      JumpIF { offset: 2 },
      Add {
        dst: r3,
        lhs: r3,
        rhs: r1,
      },
      // skip1:
      JumpL { offset: 16 },
      // outer_end:
      Halt,
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
    use Instruction::*;

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

    let r0 = 0; /* reserved */
    let r1 = 1;
    let r2 = 2;
    let r3 = 3;
    let r4 = 4;

    let code = vec![
      LoadI { dst: r1, n: 0 },
      LoadI { dst: r2, n: 1 },
      LoadI { dst: r3, n: 0 },
      // loop:
      TestLt { lhs: r3, rhs: r0 },
      JumpIF { offset: 6 },
      Add {
        dst: r4,
        lhs: r1,
        rhs: r2,
      },
      Move { src: r2, dst: r1 },
      Move { src: r4, dst: r2 },
      Addc {
        dst: r3,
        lhs: r3,
        n: 1,
      },
      JumpL { offset: 6 },
      // end:
      Return { src: r1 },
      Halt,
    ];

    let setup = |thread: &mut Thread| {
      thread.resize(5);
      thread.regs[0] = Value::int(20);
    };

    let assert = |thread: &Thread| {
      assert_eq!(thread.ret.to_int().unwrap(), crate::fib(20));
    };

    (code, setup, assert)
  }
}

#[cfg(test)]
mod tests {
  use super::*;

  #[test]
  fn test_fib_20() {
    fixture::run(fixture::fib_20);
  }

  #[test]
  fn test_simple_loop() {
    fixture::run(fixture::simple_loop);
  }

  #[test]
  fn test_nested_loop() {
    fixture::run(fixture::nested_loop);
  }

  #[test]
  fn test_longer_repetitive() {
    fixture::run(fixture::longer_repetitive);
  }

  #[test]
  fn test_unpredictable() {
    fixture::run(fixture::unpredictable);
  }
}
