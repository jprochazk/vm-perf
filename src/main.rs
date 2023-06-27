use ::vm::vm::reg::*;

#[inline(never)]
fn run() {
  let thread = fixture::run(fixture::simple_loop, dispatch::goto);
  println!("simple_loop {:?}; {}", thread.regs, thread.ret);

  let thread = fixture::run(fixture::nested_loop, dispatch::goto);
  println!("nested_loop {:?}; {}", thread.regs, thread.ret);

  let thread = fixture::run(fixture::longer_repetitive, dispatch::goto);
  println!("longer_repetitive {:?}; {}", thread.regs, thread.ret);

  let thread = fixture::run(fixture::unpredictable, dispatch::goto);
  println!("unpredictable {:?}; {}", thread.regs, thread.ret);

  let thread = fixture::run(fixture::fib_20, dispatch::goto);
  println!("fib_20 {:?}; {}", thread.regs, thread.ret);
}

fn main() {
  run()
}
