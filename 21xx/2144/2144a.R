# Compare for station 1612340 (Honolulu).
# I got the data, in file 'predictionFile', from
#https://tidesandcurrents.noaa.gov/waterlevels.html?id=1612340&units=metric&bdate=20230830&edate=20230831&timezone=GMT&datum=MLLW&interval=6&action=data
# and the harmonic coefficients, in file "const.txt", from cut/paste of the table at
# https://tidesandcurrents.noaa.gov/harcon.html?unit=0&timezone=0&id=1612340&name=Honolulu&state=HI

predictionFile <- "CO-OPS_1612340_met.csv"
harmonicFile <- "harmonics.tsv"
zoffset <- 0.268 # found by trial/error

library(oce)
options(width=200)
latitude <- 21+18.2/60 # https://tidesandcurrents.noaa.gov/stationhome.html?id=1612340

pred <- read.csv(predictionFile)
head(pred)
pred$time <- as.POSIXct(paste(pred$Date, pred$Time..GMT.), tz="UTC")
head(pred)

tRef <- mean(pred$time)
const <- read.delim(harmonicFile, sep="\t", header=TRUE)
head(const)
m <- as.tidem(tRef=tRef, latitude=latitude, name=const$Name, amplitude=const$Amplitude, phase=const$Phase)
if (!interactive())
    png("2144a.png", unit="in", height=5, width=7, res=200, pointsize=10)
plot(pred$time, pred$Predicted..m., type="l", lwd=4, col="gray")
col <- 2
tail(pred$time,1)
eta <- predict(m, pred$time)
lines(pred$time, eta + zoffset, col=2)
if (!interactive())
    dev.off()

