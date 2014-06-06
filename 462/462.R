if (!interactive()) png("462.png", width=7, height=5, unit="in", res=150, pointsize=9)
## Expect wind before Juan to be at 100deg before the wind peak and 180deg
## after it.  These are in met convention.

library(oce)
data(sealevel)
data(met)
juan <- as.POSIXct("2003-09-29 04:00:00", tz="UTC")
eta <- sealevel[['elevation']]
etap <- predict(tidem(sealevel))
start <- juan - 10 * 3600
end <- juan + 10 * 3600
time <- sealevel[['time']]
look <- start <= time & time < end
time <- time[look]
eta <- eta[look]
etap <- etap[look]

time2 <- met[['time']]
look2 <- start <= time2 & time2 < end
time2 <- time2[look2]
wind <- met[['wind']][look2] * 1000 / 3600 # m/s
direction <- 10 * met[['direction']][look2]
u <- met[['u']][look2]
v <- met[['v']][look2]
stopifnot(all(time==time2))
juan <- as.POSIXct("2003-09-29 04:00:00", tz="UTC")
par(mfrow=c(2, 1))
oce.plot.ts(time, direction, xlim=juan+10*c(-3600,3600), ylim=c(0,360))
abline(h=seq(0, 360, 60), col='gray', lty='dotted')
abline(v=juan, lty='dotted', col='red')
oce.plot.ts(time, wind)
abline(v=juan, lty='dotted', col='red')
if (!interactive()) dev.off()
