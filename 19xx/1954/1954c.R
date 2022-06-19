library(oce)
f1 <- "S102791A002_Barrow_v2.ad2cp"
d1 <- read.adp.ad2cp(f1)
str(d1)
A <- d1@data$burstAltimeterRaw
z <- seq(0, by=A$altimeterRawSampleDistance[1], length=A$altimeterRawNumberOfSamples)

if (!interactive())
    png("1954c.png")
imagep(A$time, z, d1@data$burstAltimeterRaw$altimeterRawSamples,
    ylab="Distance [m]")
if (!interactive())
    dev.off()
