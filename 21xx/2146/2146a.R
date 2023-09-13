# Honolulu
# https://tidesandcurrents.noaa.gov/stationhome.html?id=1612340
library(oce)
h <- read.delim("harmonics.tsv", sep="\t")
o <- read.csv("predictions.csv")
o$time <- as.POSIXct(o$Date.Time, tz="UTC")
head(o,2)
head(h,2)
# https://tidesandcurrents.noaa.gov/stationhome.html?id=1612340
latitude <- 21+18.2/60
if (!interactive())
    png("2146a.png", unit="in", width=7, height=7, res=200, pointsize=14)
par(mfcol=c(3, 1))
m <- as.tidem(tRef=mean(o$time), latitude=latitude,
    name=h$Name, amplitude=h$Amplitude, phase=h$Phase)
pp <- predict(m, o$time)
zoffset <- mean(pp - o$Prediction)
oce.plot.ts(o$time, o$Prediction, ylab="Level [m]", drawTimeRange=FALSE)
lines(o$time, pp-zoffset, col=2, lty="dashed", lwd=4)
mtext("NOAA station 1612340, Honolulu HI", cex=par("cex"))

oce.plot.ts(o$time, (o$Prediction+zoffset) - pp,
    ylab="Deviation after offsetting [m]",
    drawTimeRange=FALSE)
mtext(sprintf("without speed (zoffset=%.10f)", zoffset), cex=par("cex"))
abline(h=0, col=4)

# column 2: as column 1 but specifying tide 'speed'
m <- as.tidem(tRef=mean(o$time), latitude=latitude,
    name=h$Name, amplitude=h$Amplitude, phase=h$Phase,
    speed=h$Speed)
pp <- predict(m, o$time)
zoffset <- mean(pp - o$Prediction)
oce.plot.ts(o$time, (o$Prediction+zoffset) - pp, drawTimeRange=FALSE)
mtext(sprintf("with speed (zoffset=%.10f)", zoffset), cex=par("cex"))
abline(h=0, col=4)
if (!interactive())
    dev.off()



