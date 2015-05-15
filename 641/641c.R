library(oce)

tstart <- as.POSIXct("2015-05-06 13:45:22", tz='UTC')
t <- seq(tstart, tstart + .7, 0.01)
x <- rnorm(t)

if (!interactive()) png('641c.png')
options(digits.secs=3)

oce.plot.ts(t, x, debug=10)
for (sec in 22:29) {
    abline(v=as.POSIXct(paste0('2015-05-06 13:45:', sec), tz='UTC'), col=2)
    mtext(text=sec, at=as.POSIXct(paste0('2015-05-06 13:45:', sec), tz='UTC'),
          line=-1, col=2, font=2)
}

if (!interactive()) dev.off()
