library(oce)
t0 <- as.POSIXct("2018-11-19 00:00:00", tz="UTC")
if (!interactive()) png("1463a.png")
par(mfrow=c(2, 2))
for (n in c(20, 30, 40, 60)) {
    t <- seq(t0, by="1 sec", length.out=n)
    oce.plot.ts(t, seq_along(t))
}
if (!interactive()) dev.off()

