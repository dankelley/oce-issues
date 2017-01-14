library(oce)

set.seed(123)
x <- rnorm(100)

breaks <- seq(-4, 4, 2)
nbreaks <- length(breaks)
ncol <- nbreaks - 1  # need one less color than breaks
col <- oceColorsJet(ncol)[rescale(x, min(breaks), max(breaks), 1, ncol)]

if (!interactive()) png('427A.png')

par(mar = c(3, 3, 1, 1))
drawPalette(breaks, col = oceColorsJet, breaks = breaks)
plot(x, col = col, pch = 19, ylim = range(breaks))
abline(h = breaks)

if (!interactive()) dev.off()
