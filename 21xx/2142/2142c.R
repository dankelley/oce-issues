# Is there a tRef that works best?
rms <- function(x) sqrt(mean(x^2, na.rm=TRUE))

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

spd <- 86400

As <- seq(-200, 200, 1)
error <- rep(NA, length(As))
for (i in seq_along(As)) {
    tRef <- mean(pred$time) + As[i]*spd
    const <- read.delim(harmonicFile, sep="\t", header=TRUE)
    m <- as.tidem(tRef=tRef, latitude=latitude, name=const$Name, amplitude=const$Amplitude, phase=const$Phase)
    eta <- predict(m, pred$time)
    zoffset <- mean(pred$Predicted..m. - eta)
    error[i] <- rms(pred$Predicted..m. - (eta + zoffset))
    cat(sprintf("%10f %.8f\n", As[i], error[i]))
}

if (!interactive())
    png("2142c.png", unit="in", height=5, width=7, res=200, pointsize=9)
plot(As, error, type="l", ylab="RMS error [m]", xlab="tRef offset [day]")
w <- which.min(error)
mtext(sprintf("A=%.2f yields min RMS (%.8f)m", As[w], error[w]))
if (!interactive())
    dev.off()

