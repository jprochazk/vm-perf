use ::vm::vm::reg::*;

#[inline(never)]
fn run() {
  let thread = fixture::run(fixture::simple_loop, dispatch::switch);
  println!("simple_loop {:?}; {}", thread.regs, thread.ret);

  let thread = fixture::run(fixture::nested_loop, dispatch::switch);
  println!("nested_loop {:?}; {}", thread.regs, thread.ret);

  let thread = fixture::run(fixture::longer_repetitive, dispatch::switch);
  println!("longer_repetitive {:?}; {}", thread.regs, thread.ret);

  let thread = fixture::run(fixture::unpredictable, dispatch::switch);
  println!("unpredictable {:?}; {}", thread.regs, thread.ret);

  let thread = fixture::run(fixture::fib_20, dispatch::switch);
  println!("fib_20 {:?}; {}", thread.regs, thread.ret);
}

fn main() {
  run()
}
