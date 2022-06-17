library(oce)
f1 <- "S102791A002_Barrow_v2.ad2cp"
d1 <- read.adp.ad2cp(f1)
A <- d1@data$burstAltimeterRaw
z <- seq(0, by=A$altimeterRawSampleDistance, length=A$altimeterRawNumberOfSamples)

if (!interactive())
    png("1954d_%d.png")
I <- d1@data$burstAltimeterRaw$altimeterRawSamples
imagep(A$time, z, I, zlim=c(4000,7000), ylab="Distance [m]")
I2 <- apply(I, 2, median)
peaks <- z[I2>6000]
plot(z, I2, type="s", xlim=c(0,2), xlab="Distance [m]", ylab="Amplitude")
mtext(paste0("Peaks at ", paste(peaks, collapse="m and"), "m"))
grid()

if (!interactive())
    dev.off()
