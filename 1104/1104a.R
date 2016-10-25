rm(list=ls())
library(oce)
source('~/src/oce/R/ctd.R')

minp <- 0.5
maxp <- 100
soakp <- 2
p <- c(rep(soakp, 1000),
       seq(soakp, minp, length.out = 50),
       seq(minp, maxp, length.out=1000),
       rep(maxp, 100),
       seq(maxp, 0, length.out=1000))
p <- p + rnorm(p, sd=0.01)
scan <- seq_along(p)
T <- rnorm(p)
S <- rnorm(p)

d <- as.ctd(S, T, p, scan=scan)

par(mfrow=c(2, 1))
plotScan(d)
plotScan(ctdTrim(d, method='sbe'))
