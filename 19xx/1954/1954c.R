library(oce)
f <- "S102791A002_Barrow_v2.ad2cp"
d <- read.adp.ad2cp(f)
str(d)
A <- d@data$burstAltimeterRaw
z <- seq(A$blankingDistance, by=A$altimeterRawSampleDistance, length=A$altimeterRawNumberOfSamples)

if (!interactive())
    png("1954c.png")
imagep(A$time, z, d@data$burstAltimeterRaw$altimeterRawSamples,
    ylab="Distance [m]")
if (!interactive())
    dev.off()
