use ::vm::*;

#[inline(never)]
fn run() {
  let mut thread = vm::reg::Thread::new();

  let (code, num_regs) = vm::reg::fixture::fib();

  thread.resize(num_regs);
  thread.regs[0] = 20.0; // fib(20)

  vm::reg::dispatch_tail(&mut thread, &code);

  assert_eq!(thread.ret, fib(20));

  println!("{}", thread.ret);
}

fn main() {
  run()
}
