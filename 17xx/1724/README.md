# Test for issue 1724

See https://github.com/dankelley/oce/issues/1724.

## The bug

## An aside on timing

I built up both `develop` and `sf` and the timing test of the present `1724a.R`
shows that `sf` is a 3 to 10 times faster than `develop`, viz.

`sf` timing for axisStyle=1:5
```
   user  system elapsed 
  0.260   0.028   0.297 
  0.076   0.006   0.086 
  0.078   0.006   0.087 
  0.076   0.006   0.086 
  0.077   0.005   0.086 
```
`develop` timing for axisStyle=1:5
```
   user  system elapsed 
  0.947   0.047   1.002 
  0.742   0.017   0.764 
  0.735   0.013   0.754 
  0.737   0.014   0.757 
  0.729   0.013   0.748 
```
I am not too sure why the first one is slower (maybe it has to do with caching
of the functions?), but we have about a factor of 4 speedup in the first case,
and about a factor of 10 in the other cases, so `sf` is clearly preferable to
`develop`.

