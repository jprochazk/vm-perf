# vm-perf

### Running the benchmarks

Make sure that [`gnuplot`](http://www.gnuplot.info/) is installed.

```
$ cargo bench
$ ./report.py
```

### Results

<img src="./report/simple_loop_violin.svg">
<img src="./report/nested_loop_violin.svg">
<img src="./report/unpredictable_violin.svg">
