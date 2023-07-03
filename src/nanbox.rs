#![allow(clippy::wrong_self_convention)]

use std::fmt::{Debug, Display};
use std::marker::PhantomData;
use std::ptr::NonNull;

mod mask {
  //! Generic mask bits

  /// Used to determine if a value is a quiet NAN.
  pub const QNAN: u64 = 0b01111111_11111100_00000000_00000000_00000000_00000000_00000000_00000000;
  /// Used to check the type tag.
  pub const TAG: u64 = 0b11111111_11111111_00000000_00000000_00000000_00000000_00000000_00000000;
  /// Used to mask the 48 value bits.
  pub const VALUE: u64 = 0b00000000_00000000_11111111_11111111_11111111_11111111_11111111_11111111;
}
#[rustfmt::skip]
mod ty {
  //                          Tag
  //                         ┌┴─────────────┬┐
  //                         ▼              ▼▼
  pub const INT    : u64 = 0b01111111_11111100_00000000_00000000_00000000_00000000_00000000_00000000;
  pub const BOOL   : u64 = 0b01111111_11111101_00000000_00000000_00000000_00000000_00000000_00000000;
  pub const NONE   : u64 = 0b01111111_11111110_00000000_00000000_00000000_00000000_00000000_00000000;
  pub const OBJECT : u64 = 0b01111111_11111111_00000000_00000000_00000000_00000000_00000000_00000000;
}

/// A value may contain any of these types, and it's important to let the
/// compiler know about that due to the drop check.
///
/// https://doc.rust-lang.org/nomicon/dropck.html
#[allow(dead_code)]
enum PhantomValue {
  Float(f64),
  Int(i32),
  Bool(bool),
  None,
  Object(NonNull<()>),
}

/// Hebi's core `Value` type.
///
/// See the [index][`crate`] for more about the different value types and
/// their encodings.
///
/// ### Equality
///
/// Two `Value`s are considered equal if:
/// - they are both `NaN` floats, or
/// - they are both floats with an absolute value of `0`, or
/// - their underlying bit values are the same
///
/// Objects are compared by reference, not by value. This is because an object
/// may override the equality operation with arbitrary code which may even
/// require executing bytecode via the VM. If you need value equality, you
/// have to go through the VM.
#[derive(Clone, Copy)]
pub struct Value {
  bits: u64,
  _p: PhantomData<PhantomValue>,
}

#[derive(Clone, Copy)]
pub enum Type {
  Float,
  Int,
  Bool,
  None,
  Object,
}

// Constructors
impl Value {
  const fn new(bits: u64) -> Self {
    Self {
      bits,
      _p: PhantomData,
    }
  }

  #[inline]
  pub fn ty(&self) -> Type {
    let bits = self.bits;

    if (bits & mask::QNAN) != mask::QNAN {
      Type::Float
    } else {
      let tag = bits & mask::TAG;

      match tag {
        ty::INT => Type::Int,
        ty::BOOL => Type::Bool,
        ty::NONE => Type::None,
        ty::OBJECT => Type::Object,
        _ => unsafe { core::hint::unreachable_unchecked() },
      }
    }
  }

  pub fn float(v: f64) -> Self {
    let bits = v.to_bits();
    if bits & mask::QNAN == mask::QNAN {
      panic!("cannot construct a Value from an f64 which is already a quiet NaN");
    }
    Self::new(bits)
  }

  pub fn int(v: i32) -> Self {
    // We want the bits of `v`, not for it to be reinterpreted as an unsigned int.
    let bits = unsafe { std::mem::transmute::<i32, u32>(v) } as u64;
    let bits = bits | ty::INT;
    Self::new(bits)
  }

  pub fn bool(v: bool) -> Self {
    let bits = v as u64;
    let bits = bits | ty::BOOL;
    Self::new(bits)
  }

  pub const fn none() -> Self {
    let bits = ty::NONE;
    Self::new(bits)
  }

  pub fn object(ptr: NonNull<()>) -> Self {
    let bits = ptr.as_ptr() as usize as u64;
    let bits = (bits & mask::VALUE) | ty::OBJECT;
    Self::new(bits)
  }
}

// Type checks
impl Value {
  #[inline]
  fn value(&self) -> u64 {
    self.bits & mask::VALUE
  }

  #[inline]
  fn type_tag(&self) -> u64 {
    self.bits & mask::TAG
  }

  #[inline]
  pub fn is_float(&self) -> bool {
    (self.bits & mask::QNAN) != mask::QNAN
  }

  #[inline]
  pub fn is_int(&self) -> bool {
    self.type_tag() == ty::INT
  }

  #[inline]
  pub fn is_bool(&self) -> bool {
    self.type_tag() == ty::BOOL
  }

  #[inline]
  pub fn is_none(&self) -> bool {
    self.type_tag() == ty::NONE
  }

  #[inline]
  pub fn is_object(&self) -> bool {
    self.type_tag() == ty::OBJECT
  }
}

impl Value {
  #[inline]
  pub fn to_float(self) -> Option<f64> {
    if self.is_float() {
      Some(unsafe { self.to_float_unchecked() })
    } else {
      None
    }
  }

  /// # Safety
  /// `self.is_float()` must be `true`
  #[inline]
  pub unsafe fn to_float_unchecked(self) -> f64 {
    debug_assert!(self.is_float());
    f64::from_bits(self.bits)
  }

  #[inline]
  pub fn to_int(self) -> Option<i32> {
    if self.is_int() {
      Some(unsafe { self.to_int_unchecked() })
    } else {
      None
    }
  }

  /// # Safety
  /// `self.is_int()` must be `true`
  #[inline]
  pub unsafe fn to_int_unchecked(self) -> i32 {
    debug_assert!(self.is_int());
    self.value() as u32 as i32
  }

  #[inline]
  pub fn to_bool(self) -> Option<bool> {
    if self.is_bool() {
      Some(unsafe { self.to_bool_unchecked() })
    } else {
      None
    }
  }

  /// # Safety
  /// `self.is_bool()` must be `true`
  #[allow(clippy::transmute_int_to_bool)]
  #[inline]
  pub unsafe fn to_bool_unchecked(self) -> bool {
    debug_assert!(self.is_bool());
    unsafe { ::core::mem::transmute(self.value() as u8) }
  }

  #[inline]
  pub fn to_none(self) -> Option<()> {
    if self.is_none() {
      Some(())
    } else {
      None
    }
  }

  /// # Safety
  /// `self.is_none()` must be `true`
  #[allow(clippy::unused_unit)]
  #[inline]
  pub unsafe fn to_none_unchecked(self) -> () {
    debug_assert!(self.is_none());
    ()
  }

  #[inline]
  pub fn to_object(self) -> Option<NonNull<()>> {
    if self.is_object() {
      Some(unsafe { self.to_object_unchecked() })
    } else {
      None
    }
  }

  /// # Safety
  /// `self.is_object()` must be `true`
  #[inline]
  pub unsafe fn to_object_unchecked(self) -> NonNull<()> {
    debug_assert!(self.is_object());
    unsafe { NonNull::new_unchecked(self.value() as usize as *mut ()) }
  }
}

macro_rules! impl_arith_op {
  ($it:ident, $op:tt) => (
    pub fn $it(self, other: Value) -> Value {
      unsafe {
        if self.is_int() && other.is_int() {
          Value::int(self.to_int_unchecked() $op other.to_int_unchecked())
        } else if self.is_int() && other.is_float() {
          Value::float(self.to_int_unchecked() as f64 $op other.to_float_unchecked())
        } else if self.is_float() && other.is_int() {
          Value::float(self.to_float_unchecked() $op other.to_int_unchecked() as f64)
        } else if self.is_float() && other.is_float() {
          Value::float(self.to_float_unchecked() $op other.to_float_unchecked())
        } else {
          panic!("type mismatch {self:?} {other:?}")
        }
      }
    }
  );
}

macro_rules! impl_cmp_op {
  ($it:ident, $op:tt) => {
    pub fn $it(self, other: Value) -> bool {
      unsafe {
        if self.is_int() && other.is_int() {
          (self.to_int_unchecked()) $op (other.to_int_unchecked())
        } else if self.is_int() && other.is_float() {
          (self.to_int_unchecked() as f64) $op (other.to_float_unchecked())
        } else if self.is_float() && other.is_int() {
          (self.to_float_unchecked()) $op (other.to_int_unchecked() as f64)
        } else if self.is_float() && other.is_float() {
          (self.to_float_unchecked()) $op (other.to_float_unchecked())
        } else if self.is_bool() && other.is_bool() {
          (self.to_bool_unchecked()) $op (other.to_bool_unchecked())
        } else if self.is_none() && other.is_none() {
          (()) $op (())
        } else if self.is_object() && other.is_object() {
          unimplemented!()
        } else {
          panic!("type mismatch {self:?} {other:?}")
        }
      }
    }
  }
}

impl Value {
  impl_arith_op!(op_add, +);
  impl_arith_op!(op_sub, -);
  impl_arith_op!(op_mul, *);
  impl_arith_op!(op_div, /);
  impl_arith_op!(op_rem, %);

  impl_cmp_op!(op_gt, >);
  impl_cmp_op!(op_ge, >=);
  impl_cmp_op!(op_lt, <);
  impl_cmp_op!(op_le, <=);
  impl_cmp_op!(op_eq, ==);
  impl_cmp_op!(op_ne, !=);
}

impl Debug for Value {
  fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
    match self.ty() {
      Type::Float => f
        .debug_tuple("Float")
        .field(&unsafe { self.to_float_unchecked() })
        .finish(),
      Type::Int => f
        .debug_tuple("Int")
        .field(&unsafe { self.to_int_unchecked() })
        .finish(),
      Type::Bool => f
        .debug_tuple("Bool")
        .field(&unsafe { self.to_bool_unchecked() })
        .finish(),
      Type::None => f.debug_tuple("None").finish(),
      Type::Object => unimplemented!(),
    }
  }
}

impl Display for Value {
  fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
    match self.ty() {
      Type::Float => write!(f, "{}", unsafe { self.to_float_unchecked() }),
      Type::Int => write!(f, "{}", unsafe { self.to_int_unchecked() }),
      Type::Bool => write!(f, "{}", unsafe { self.to_bool_unchecked() }),
      Type::None => write!(f, "()"),
      Type::Object => unimplemented!(),
    }
  }
}
