#![allow(non_snake_case)]

#[doc(hidden)]
#[macro_export]
macro_rules! __declare_instruction_set {
  (__make_instruction $(#[$meta:meta])* ($op:expr) => $name:ident (abc $a:ident $b:ident $c:ident)) => {
    $(#[$meta])*
    pub fn $name($a: u8, $b: u8, $c: u8) -> $crate::op::Instruction {
      $crate::op::Instruction::abc($op, $a, $b, $c)
    }
  };
  (__make_instruction $(#[$meta:meta])* ($op:expr) => $name:ident (Lb $L:ident $b:ident)) => {
    $(#[$meta])*
    pub fn $name($L: u16, $b: u8) -> $crate::op::Instruction {
      $crate::op::Instruction::Lb($op, $L, $b)
    }
  };
  (__make_instruction $(#[$meta:meta])* ($op:expr) => $name:ident (bL $b:ident $L:ident)) => {
    $(#[$meta])*
    pub fn $name($b: u8, $L: u16) -> $crate::op::Instruction {
      $crate::op::Instruction::bL($op, $b, $L)
    }
  };
  (__make_instruction $(#[$meta:meta])* ($op:expr) => $name:ident (Ix $I:ident $x:ident)) => {
    $(#[$meta])*
    pub fn $name($I: i16, $x: u8) -> $crate::op::Instruction {
      $crate::op::Instruction::Ix($op, $I, $x)
    }
  };
  (__make_instruction $(#[$meta:meta])* ($op:expr) => $name:ident (xI $x:ident $I:ident)) => {
    $(#[$meta])*
    pub fn $name($x: u8, $I: i16) -> $crate::op::Instruction {
      $crate::op::Instruction::xI($op, $x, $I)
    }
  };

  (
    $inst:ident($opcode:ident, $make:ident) {

      _ $(#[$nop_meta:meta])* nop;

      $(
        $(#[$meta:meta])*
        $name:ident: $kind:ident($($operand:ident),*);
      )*


      _ $(#[$hlt_meta:meta])* hlt;
    }
  ) => {
    mod $inst {
      #![allow(non_camel_case_types)]
      #![allow(non_upper_case_globals)]
      #![allow(non_snake_case)]
      #![allow(dead_code)]

      pub mod $opcode {
        #[repr(u8)]
        enum Index {
          nop,
          $($name,)*
          hlt,
        }

        $(#[$nop_meta])*
        pub const nop: $crate::op::Opcode = Index::nop as $crate::op::Opcode;

        $(
          $(#[$meta])*
          pub const $name: $crate::op::Opcode = Index::$name as $crate::op::Opcode;
        )*

        $(#[$hlt_meta])*
        pub const hlt: $crate::op::Opcode = Index::hlt as $crate::op::Opcode;
      }

      pub mod $make {
        $(#[$nop_meta])*
        pub fn nop() -> $crate::op::Instruction {
          $crate::op::Instruction::abc(super::$opcode::nop, 0, 0, 0)
        }

        $(
          $crate::__declare_instruction_set!(
            __make_instruction
            $(#[$meta])*
            (super::$opcode::$name) => $name ( $kind $($operand)* )
          );
        )*

        $(#[$hlt_meta])*
        pub fn hlt() -> $crate::op::Instruction {
          $crate::op::Instruction::abc(super::$opcode::hlt, 0, 0, 0)
        }
      }
    }
  };
}

pub use crate::__declare_instruction_set as instruction_set;

pub type Opcode = u8;

#[repr(C)]
#[derive(Clone, Copy)]
pub struct Instruction {
  pub op: Opcode,
  pub args: Args,
}

impl Instruction {
  pub fn abc(op: Opcode, a: u8, b: u8, c: u8) -> Self {
    Self {
      op,
      args: Args {
        abc: abc { a, b, c },
      },
    }
  }

  pub fn Lb(op: Opcode, L: u16, b: u8) -> Self {
    Self {
      op,
      args: Args { Lb: Lb { L, b } },
    }
  }

  pub fn bL(op: Opcode, b: u8, L: u16) -> Self {
    Self {
      op,
      args: Args { bL: bL { b, L } },
    }
  }

  pub fn Ix(op: Opcode, I: i16, x: u8) -> Self {
    Self {
      op,
      args: Args { Ix: Ix { I, x } },
    }
  }

  pub fn xI(op: Opcode, x: u8, I: i16) -> Self {
    Self {
      op,
      args: Args { xI: xI { x, I } },
    }
  }
}

#[repr(C)]
#[derive(Clone, Copy)]
pub union Args {
  abc: abc,
  Lb: Lb,
  bL: bL,
  Ix: Ix,
  xI: xI,
}

impl Args {
  pub fn abc(&self) -> &abc {
    unsafe { &self.abc }
  }

  pub fn Lb(&self) -> &Lb {
    unsafe { &self.Lb }
  }

  pub fn bL(&self) -> &bL {
    unsafe { &self.bL }
  }

  pub fn Ix(&self) -> &Ix {
    unsafe { &self.Ix }
  }

  pub fn xI(&self) -> &xI {
    unsafe { &self.xI }
  }
}

use private::*;

mod private {
  #[repr(C)]
  #[derive(Clone, Copy)]
  pub struct abc {
    pub a: u8,
    pub b: u8,
    pub c: u8,
  }

  #[repr(C)]
  #[derive(Clone, Copy)]
  pub struct Lb {
    pub L: u16,
    pub b: u8,
  }

  #[repr(C)]
  #[derive(Clone, Copy)]
  pub struct bL {
    pub b: u8,
    pub L: u16,
  }

  #[repr(C)]
  #[derive(Clone, Copy)]
  pub struct Ix {
    pub I: i16,
    pub x: u8,
  }

  #[repr(C)]
  #[derive(Clone, Copy)]
  pub struct xI {
    pub x: u8,
    pub I: i16,
  }
}
