# Compare for station 1612340 (Honolulu).
# I got the data, in file 'predictionFile', from
#https://tidesandcurrents.noaa.gov/waterlevels.html?id=1612340&units=metric&bdate=20230830&edate=20230831&timezone=GMT&datum=MLLW&interval=6&action=data
# and the harmonic coefficients, in file "const.txt", from cut/paste of the table at
# https://tidesandcurrents.noaa.gov/harcon.html?unit=0&timezone=0&id=1612340&name=Honolulu&state=HI

predictionFile <- "CO-OPS_1612340_met.csv"
harmonicFile <- "harmonics.tsv"

library(oce)
options(width=200)
latitude <- 21+18.2/60 # https://tidesandcurrents.noaa.gov/stationhome.html?id=1612340

pred <- read.csv(predictionFile)
head(pred)
pred$time <- as.POSIXct(paste(pred$Date, pred$Time..GMT.), tz="UTC")
head(pred)

#tRef <- mean(pred$time)
tRef <- mean(c(ISOdate(1983,1,1, tz="UTC"),ISOdate(2001,12,31, tz="UTC")))
const <- read.delim(harmonicFile, sep="\t", header=TRUE)
head(const)
m <- as.tidem(tRef=tRef, latitude=latitude, name=const$Name, amplitude=const$Amplitude, phase=const$Phase)
if (!interactive())
    png("2142b.png", unit="in", height=5, width=7, res=200, pointsize=9)
layout(matrix(1:2,ncol=1), height=c(0.6,0.4))
plot(pred$time, pred$Predicted..m., type="l", xlab="Time [UTC] in Year 2023",
    xaxs="i", ylim=c(-0.05, 0.8), lwd=4, col="gray", ylab="Water Level [m]")
mtext("Honolulu (station 1612340)", col=4, font=2, adj=1)
eta <- predict(m, pred$time)
zoffset <- mean(pred$Predicted..m. - eta)
lines(pred$time, eta + zoffset, col=2)
rms <- function(x) sqrt(mean(x^2))
error <- rms(pred$Predicted..m. - (eta + zoffset))
legend("topright", lwd=c(4, 1), col=c("gray", 2), bg="white",
    legend=c("NOAA prediction", paste("oce, with", round(zoffset,4), "m added")))
mtext(sprintf("RMS mismatch after offset: %.6f m", error), adj=0)

plot(pred$time, pred$Predicted..m. - (eta + zoffset),
    type="l", xlab="Time [UTC] in Year 2023", xaxs="i", ylab="Mismatch [m]")
abline(h=0, col=4)

if (!interactive())
    dev.off()

