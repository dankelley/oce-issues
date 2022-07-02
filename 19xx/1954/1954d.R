library(oce)
d <- read.adp.ad2cp("S102791A002_Barrow_v2.ad2cp", debug=0)
A <- d@data$burstAltimeterRaw
z <- seq(A$blankingDistance, by=A$altimeterRawSampleDistance, length=A$altimeterRawNumberOfSamples)

if (!interactive())
    png("1954d_%d.png", width=7, height=7, unit="in", res=250)
I <- d@data$burstAltimeterRaw$altimeterRawSamples
imagep(A$time, z, I, zlim=c(4000,7000), ylab="Distance [m]", decimate=FALSE)
imagep(A$time, z, I, ylim=40+c(0,3), zlim=c(4000,7000), ylab="Distance [m]", decimate=FALSE)
I2 <- apply(I, 2, median)
peaks <- z[I2>6000]
plot(z, I2, type="s", xlim=40+c(0,2), xlab="Distance [m]", ylab="Amplitude")
mtext(paste0("Peaks at ", paste(peaks, collapse="m and "), "m"))
grid()

if (!interactive())
    dev.off()
