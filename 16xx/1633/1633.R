library(oce)

if (!interactive()) pdf("1633.pdf")

## 1632
data(adp)
plot(adp, which=c(5, 'pressure'))

## 1633
Sv <- c(0.66, 0.8, 1, 1.2, 1.5)
t0 <- as.POSIXct("2020-01-01 00:00:00", tz="UTC")
t <- seq(from=t0, length.out=24, by="hour")
p <- sin(2*pi*(as.numeric(t)-as.numeric(t0))/86400)
for (Sa in Sv) {
    for (Sl in Sv) {
        par(mfrow=c(1, 1))
        oce.plot.ts(t, p, cex.axis=Sa, cex.lab=Sl)
        par(mfrow=c(2, 2))
        for (i in 1:4)
            oce.plot.ts(t, p, cex.axis=Sa, cex.lab=Sl)
        par(mfrow=c(4, 1))
        for (i in 1:4)
            oce.plot.ts(t, p, cex.axis=Sa, cex.lab=Sl)
        par(mfrow=c(1, 4))
        for (i in 1:4)
            oce.plot.ts(t, p, cex.axis=Sa, cex.lab=Sl)
    }
}

if (!interactive()) dev.off()

