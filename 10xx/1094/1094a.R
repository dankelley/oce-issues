rm(list=ls())
library(oce)

start <- as.POSIXct('2016-09-28 00:00:00', tz='UTC')
deltat <- c(5, 6, 11)
if (!interactive()) png("1094a.png")
par(mfrow=c(length(deltat), 1))
for (dt in deltat) { # hours
    t <- seq(start, start + dt*3600, by=60)
    yy <- rnorm(length(t))
    oce.plot.ts(t, yy)
    mtext(paste("dt:", dt, "hours"), side=3, line=0, adj=1)
}
if (!interactive()) dev.off()

