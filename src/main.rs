use ::vm::vm::reg::*;

#[inline(never)]
fn run() {
  let thread = fixture::run(fixture::fib_20, dispatch::goto);
  println!("{}", thread.ret);
}

fn main() {
  run()
}
