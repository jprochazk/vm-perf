# vm-perf

## Running the benchmarks

Make sure that [`gnuplot`](http://www.gnuplot.info/) is installed.

```
$ cargo bench
$ ./report.py
```

## Results

### Simple loop

A basic loop. The body of the loop does no work other than decrement the counter from `42` to `0`.

<img src="./report/simple_loop_violin.svg">

### Nested loop

The same as [simple loop](#simple-loop), but nested where `i` starts at `10000` and `j` starts at `100`.

<img src="./report/nested_loop_violin.svg">

### Longer repetitive

The same as [nested loop](#nested-loop), but each instruction is followed by 3 `add` instructions which all add zero to a variable.

<img src="./report/longer_repetitive_violin.svg">

### Unpredictable

Similar to [nested loop](#nested-loop), but randomly repeats iterations of both the inner and outer loop. The idea is to make the loop. The rng uses the same seed for all dispatch methods, so they all do the same number of iterations.

<img src="./report/unpredictable_violin.svg">

### 20th fibonacci number

Uses an iterative algorithm to calculate the 20th fibonacci number.

<img src="./report/fib_20_violin.svg">
