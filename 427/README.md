# Issue 427: "`rescale()` has odd behavior at end points", or "`drawPalette()` should do the work of `rescale()` to return a vector of colors according to the input parameters"

When using `rescale()` to create a color vector, it returns floating point numbers, which are poor indices for assigning colors. For example, in the code below, which assigns 10 colors to a vector 100 points long, only the *highest* value will be assigned the extreme color (dark red), rather than according to a sensible choice of `breaks` given the range and the number of colors provided.


```r
library(oce)
set.seed(123)
x <- rnorm(100)
xscaled <- rescale(x, rlow = 1, rhigh = 10)
xscaled
```

```
##   [1]  4.500  5.161  8.742  5.763  5.881  9.055  6.544  3.090  4.247  4.730
##  [11]  8.072  6.342  6.424  5.843  4.509  9.199  6.618  1.686  7.026  4.676
##  [21]  3.485  5.186  3.568  4.163  4.371  2.246  7.299  5.929  3.344  8.132
##  [31]  6.476  5.031  7.414  7.380  7.266  7.000  6.731  5.498  5.010  4.860
##  [41]  4.231  5.206  3.089  9.963  8.040  3.374  4.816  4.688  7.183  5.455
##  [51]  6.129  5.565  5.536  8.361  5.170  8.657  2.522  6.792  5.870  6.054
##  [61]  6.382  4.617  4.955  3.583  3.477  6.229  6.519  5.728  7.468  9.725
##  [71]  4.639  1.000  7.635  4.202  4.245  7.675  5.052  3.179  5.985  5.344
##  [81]  5.633  6.393  4.880  6.912  5.181  6.286  7.817  6.493  4.970  7.921
##  [91]  7.610  6.720  6.100  4.365  8.345  4.420 10.000  8.690  5.150  3.567
```

```r
col <- oceColorsJet(10)[xscaled]
```


This is mostly ok (or at least not visibly wrong) when there are a lot of colors (and data points), but for instances where one would desire a finite number of colors (say, to plot values by month), it makes it impossible to line up a palette (with breaks) produced using `drawPalette()` and the vector of colors produced using `rescale()`.

Another example: plot `x` from above with breaks `seq(-4, 4, 2)`, and make a palette that matches the colors assigned to the points:


```r
breaks <- seq(-4, 4, 2)
nbreaks <- length(breaks)
ncol <- nbreaks - 1  # need one less color than breaks
col <- oceColorsJet(ncol)[rescale(x, min(breaks), max(breaks), 1, ncol)]
par(mar = c(3, 3, 1, 1))
drawPalette(breaks, col = oceColorsJet, breaks = breaks)
plot(x, col = col, pch = 19, ylim = range(breaks))
abline(h = breaks)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 


It can clearly be seen that the colors are being assigned to the points incorrectly.

The issue outlined above occurs because `rescale()` returns floating point numbers, which when used as indices for resorting the palette vector are converted to integers. Thus, as shown, only the highest value corresponds to the `rhigh` arg, and thus is the only point to receive the upper extreme of the color range.

## Possible functional solution with drawPalette()??

A possible solution could be to make `drawPalette()` return a vector of colors that could be used to plot points, based on the `zlim` arg which it is given (i.e. could be the vector `x`) and the breaks specified


```r
col <- drawPalette(x, col = oceColorsJet, breaks = seq(-4, 4, 2))
plot(x, col = col)
```


For this example note that the vector `col` would be of the appropriate length according to the provided `x` and the colors assigned properly according to the specified `breaks`.

