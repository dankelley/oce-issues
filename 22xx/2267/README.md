This tests the new grid capabilities of oce.plot.ts().  Type

```sh
make clean
make
```

and then look at the PNG files, paying close attention to the ones with 'month'
in the filename. You should see blue vertical lines in some of them, which are
not quite at the right place to match the axis ticks.  Those blue lines only
occur if (as in this test) oce.plot.ts() is called with `debug` set to an
positive  integer.

As you scan the PNG files, please take note of any in which the vertical (red and dashed yellow)
lines are not directly above the axis ticks. If you see any, please go to

https://github.com/dankelley/oce/issues/2267

and add a comment, or raise a new issue.
