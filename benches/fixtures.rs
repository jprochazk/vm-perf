use criterion::{criterion_group, criterion_main, Criterion};

macro_rules! bench_fixture {
  ($fixture:ident) => {
    pub fn $fixture(c: &mut Criterion) {
      let mut group = c.benchmark_group(stringify!($fixture));
      bench_fixture!(@function group, switch, $fixture);
      bench_fixture!(@function group, tail, $fixture);
      bench_fixture!(@function group, goto, $fixture);
    }
  };
  (@function $group:ident, $dispatch:ident, $fixture:ident) => {
    $group.bench_function(
      stringify!($dispatch),
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

bench_fixture!(simple_loop);
bench_fixture!(nested_loop);
bench_fixture!(longer_repetitive);
bench_fixture!(unpredictable);
bench_fixture!(fib_20);

criterion_group!(
  benches,
  //fib_20,
  simple_loop,
  nested_loop,
  //longer_repetitive,
  unpredictable
);

criterion_main!(benches);
