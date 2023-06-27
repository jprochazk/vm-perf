use criterion::{criterion_group, criterion_main, Criterion};

macro_rules! bench_fixture {
  ($fixture:ident) => {
    pub fn $fixture(c: &mut Criterion) {
      bench_fixture!(@function c switch $fixture);
      bench_fixture!(@function c tail $fixture);
      bench_fixture!(@function c goto $fixture);
    }
  };
  (@function $c:ident $dispatch:ident $fixture:ident) => {
    $c.bench_function(
      concat!(stringify!($dispatch), ".", stringify!($fixture)),
      |b| {
        use ::vm::vm::reg::*;
        b.iter_with_setup(
          || {
            let mut thread = Thread::new();
            let (code, setup, assert) = fixture::$fixture();
            setup(&mut thread);
            (thread, code, assert)
          },
          |(mut thread, code, assert)| {
            dispatch::$dispatch(&mut thread, &code);
            assert(&thread);
          },
        );
      },
    )
  };
}

bench_fixture!(fib_20);
bench_fixture!(simple_loop);
bench_fixture!(nested_loop);
bench_fixture!(longer_repetitive);
bench_fixture!(unpredictable);

criterion_group!(
  benches,
  fib_20,
  simple_loop,
  nested_loop,
  longer_repetitive,
  unpredictable
);

criterion_main!(benches);
