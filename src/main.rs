use ::vm::thread::*;

#[inline(never)]
fn run() {
  let thread = fixture::run(fixture::simple_loop);
  println!("simple_loop {:?}; {}", thread.regs, thread.ret);

  let thread = fixture::run(fixture::nested_loop);
  println!("nested_loop {:?}; {}", thread.regs, thread.ret);

  let thread = fixture::run(fixture::longer_repetitive);
  println!("longer_repetitive {:?}; {}", thread.regs, thread.ret);

  let thread = fixture::run(fixture::unpredictable);
  println!("unpredictable {:?}; {}", thread.regs, thread.ret);

  let thread = fixture::run(fixture::fib_20);
  println!("fib_20 {:?}; {}", thread.regs, thread.ret);
}

fn main() {
  run()
}
