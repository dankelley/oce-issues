# Alter K1 amplitude by a rounding error, to see what that does to misfit
rm(list=ls())
eps <- 0.001 # digit resolution of harmonic amplitude, altered here
library(oce)

latitude <- 21+18.2/60

# observations at Honolulu
# https://tidesandcurrents.noaa.gov/stationhome.html?id=1612340
o <- read.csv("predictions.csv")
o$time <- as.POSIXct(o$Date.Time, tz="UTC")
tRef <- mean(o$time)

# harmonics (h0=raw, h1=K1 amp increased, h2=K1 amp decreased)
h0 <- read.delim("harmonics.tsv", sep="\t")
w <- which(h0$Name == "K1")
stopifnot(w == 4) # ensure we got the right one (based on examining file)
h1 <- h0
h1[w, "Amplitude"] <- h1[w, "Amplitude"] + eps
h2 <- h0
h2[w, "Amplitude"] <- h2[w, "Amplitude"] - eps

# models: m0=using oce frequencies, m1=using speed,
# m2=using speed with K1 amplitude increased by eps,
# and m3=using speed with K1 amp decreased by eps.  The
# p values correspond.
m0 <- as.tidem(tRef=tRef, latitude=latitude,
    name=h0$Name, amplitude=h0$Amplitude, phase=h0$Phase)
p0 <- predict(m0, o$time)

m1 <- as.tidem(tRef=tRef, latitude=latitude,
    name=h1$Name, amplitude=h1$Amplitude, phase=h1$Phase, speed=h1$Speed)
p1 <- predict(m1, o$time)

m2 <- as.tidem(tRef=tRef, latitude=latitude,
    name=h2$Name, amplitude=h2$Amplitude, phase=h2$Phase)
p2 <- predict(m2, o$time)

zoffset <- mean(p0 - o$Prediction) # use for all 3 predictions

# https://tidesandcurrents.noaa.gov/stationhome.html?id=1612340
if (!interactive())
    png("2146c.png", unit="in", width=7, height=7, res=200, pointsize=12)
par(mfcol=c(2, 1))
oce.plot.ts(o$time, o$Prediction, ylab="Level [m]", drawTimeRange=FALSE,
    xaxs="i", col="lightgray", lwd=5)
lines(o$time, p0-zoffset, lwd=1)
mtext("NOAA station 1612340, Honolulu HI", cex=par("cex"))

oce.plot.ts(o$time, o$Prediction - (p0-zoffset),
    xaxs="i", ylim=c(-5e-3, 5e-3),
    ylab="Level Misfit [m]",
    drawTimeRange=FALSE)
abline(h=0, col="gray")
lines(o$time, o$Prediction - (p1-zoffset), col=2)
lines(o$time, o$Prediction - (p2-zoffset), col=3)
legend("topleft", lwd=1, col=1:3,
    legend=c("unperturbed",
        paste("K1 inc by", eps, "m"),
        paste("K1 dec by", eps, "m")), cex=0.8)

if (!interactive())
    dev.off()



