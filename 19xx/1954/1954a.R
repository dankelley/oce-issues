# see R/adp.nortek.ad2cp.R bookmark01 etc
# 01: key=0x1a (burst altimeter raw)
library(oce)
f1 <- "S102791A002_Barrow_v2.ad2cp"
#d1 <- read.adp.ad2cp(f1, debug=3)
#d1 <- read.adp.ad2cp(f1)
d1 <- read.adp.ad2cp(f1, debug=2)
str(d1@data$average,1)
if (!interactive())
    png("1954a_%d.png")
par(mfrow=c(3,1))
with(d1@data$average,
    {
        oce.plot.ts(time, magnetometerx)
        oce.plot.ts(time, magnetometery)
        oce.plot.ts(time, magnetometerz)
    })

A <- d1@data$burstAltimeterRaw
str(A)
z <- seq(0, by=A$altimeterRawSampleDistance, length=A$altimeterRawNumberOfSamples)

par(mfrow=c(1,1))
imagep(A$time, z, d1@data$burstAltimeterRaw$altimeterRawSamples,
    ylab="Distance [m]")

if (!interactive())
    dev.off()
