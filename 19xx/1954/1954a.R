# see R/adp.nortek.ad2cp.R bookmark01 etc
# 01: key=0x1a (burst altimeter raw)
library(oce)
library(testthat)

f <- "S102791A002_Barrow_v2.ad2cp"
D <- read.adp.ad2cp(f, debug=2)

# compare with data read with previous, unvectorized, code.
load("1954a_unvectorized.rda") # d
expect_equal(0L, diff(range(D@data$burstAltimeterRaw$altimeterRawSamples-d@data$burstAltimeterRaw$altimeterRawSamples)))

if (!interactive())
    png("1954a_%d.png")
par(mfrow=c(3,1))
with(d@data$average,
    {
        oce.plot.ts(time, magnetometerx)
        oce.plot.ts(time, magnetometery)
        oce.plot.ts(time, magnetometerz)
    })

A <- d@data$burstAltimeterRaw
str(A)
z <- seq(0, by=A$altimeterRawSampleDistance[1], length=A$altimeterRawNumberOfSamples)

par(mfrow=c(1,1))
imagep(A$time, z, d@data$burstAltimeterRaw$altimeterRawSamples,
    ylab="Distance [m]")

par(mfrow=c(3,1))
oce.plot.ts(A$time, A$pressure)
oce.plot.ts(A$time, A$temperature)
oce.plot.ts(A$time, A$ASTDistance)

save(d, file="1954a.rda")

if (!interactive())
    dev.off()
