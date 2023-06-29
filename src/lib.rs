#[macro_use]
pub mod util;

pub mod dispatch;
pub mod nanbox;
pub mod op;
pub mod vm;

pub fn fib(n: usize) -> i32 {
  let mut a = 0;
  let mut b = 1;
  for _ in 0..n {
    (a, b) = (b, a + b);
  }
  a
}
