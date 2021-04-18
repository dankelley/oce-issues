# Timing test for oce.plot.ts() with simplify=2560.

N <- 3e7
set.seed(1805)
library(oce)
t0 <- as.POSIXct("2021-01-01", tz="UTC")
t <- t0 + 1:N
y <- sin(2 * pi * as.numeric(t) / (N/5)) + rnorm(length(t), sd=1)
if (!interactive()) png("1805a.png")
par(mfrow=c(2, 1))
userTime <- system.time(oce.plot.ts(t, y, type="l", drawTimeRange=FALSE, simplify=NA))[1]
mtext(sprintf("Original: %.3f sec for %g points", userTime, N))
userTime <- system.time(oce.plot.ts(t, y, type="l", drawTimeRange=FALSE))[1]
mtext(sprintf("Simplified: %.3f sec for %g points", userTime, N))
if (!interactive()) dev.off()

