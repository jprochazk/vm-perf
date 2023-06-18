pub mod dispatch;
pub mod op;
pub mod vm;

#[cfg(test)]
mod tests {
  pub fn fib(n: usize) -> f64 {
    let mut a = 0.0;
    let mut b = 1.0;
    for _ in 0..n {
      (a, b) = (b, a + b);
    }
    a
  }
}
