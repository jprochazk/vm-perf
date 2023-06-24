use criterion::{criterion_group, criterion_main, Criterion};

pub fn fib_goto(c: &mut Criterion) {
  use ::vm::*;

  c.bench_function("fib_goto(20)", |b| {
    b.iter_with_setup(
      || {
        let mut thread = vm::reg::Thread::new();
        let (code, num_regs) = vm::reg::fixture::fib();
        thread.resize(num_regs);
        thread.regs[0] = 20.0; // prepare call to `fib(20)`
        (thread, code)
      },
      |(mut thread, code)| {
        unsafe { vm::reg::dispatch_goto(&mut thread, &code) };
        assert_eq!(thread.ret, fib(20));
      },
    );
  });
}

pub fn fib_switch(c: &mut Criterion) {
  use ::vm::*;

  c.bench_function("fib_switch(20)", |b| {
    b.iter_with_setup(
      || {
        let mut thread = vm::reg::Thread::new();
        let (code, num_regs) = vm::reg::fixture::fib();
        thread.resize(num_regs);
        thread.regs[0] = 20.0; // prepare call to `fib(20)`
        (thread, code)
      },
      |(mut thread, code)| {
        vm::reg::dispatch_switch(&mut thread, &code);
        assert_eq!(thread.ret, fib(20));
      },
    );
  });
}

criterion_group!(fib, fib_switch, fib_goto);
criterion_main!(fib);
