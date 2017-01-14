rm(list=ls())
library(oce)

minp <- 1
maxp <- 200
soakp <- 10
p <- c(seq(0, soakp, length.out=10),
       rep(soakp, 1000),
       seq(soakp, minp, length.out = 10),
       rep(minp, length.out=20),
       seq(minp, maxp, length.out=1000),
       rep(maxp, 100),
       seq(maxp, 0, length.out=1000))
p <- p + rnorm(p, sd=0.1)
scan <- seq_along(p)
T <- rnorm(p)
S <- rnorm(p)

d <- as.ctd(S, T, p, scan=scan)
dt <- ctdTrim(d, method='sbe', parameters=list(minSoak=5), debug=10)

if (!interactive()) png('1104a.png')

par(mfrow=c(2, 1))
plotScan(d)
plotScan(dt)

if (!interactive()) dev.off()
