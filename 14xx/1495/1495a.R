library(oce)

set.seed(20)
n <- 100
y <- 1:n + 10 ^ rnorm(n)
t <- as.POSIXct(seq(as.Date('2017-01-01'), by = 'day', length.out = n))

if (!interactive()) png("1485a.png")
par(mfrow=c(2, 2))
oce.plot.ts(x = t, y = y)
grid() # lets us see if base grid() has same colour etc
oce.plot.ts(x = t, y = y, log = 'y')
oce.plot.ts(x = t, y = y, grid = TRUE)
oce.plot.ts(x = t, y = y, log = 'y', grid = TRUE)
if (!interactive()) dev.off()
