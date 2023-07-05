#[macro_use]
pub mod util;

pub mod nanbox;
pub mod op;
pub mod thread;

pub type Error = String;
pub type Result<T, E = Error> = ::core::result::Result<T, E>;

pub fn fib(n: usize) -> i32 {
  let mut a = 0;
  let mut b = 1;
  for _ in 0..n {
    (a, b) = (b, a + b);
  }
  a
}
