library(oce)
f1 <- "S102791A002_Barrow_v2.ad2cp"
#d1 <- read.adp.ad2cp(f1, debug=3)
d1 <- read.adp.ad2cp(f1)
str(d1@data$average,1)
if (!interactive())
    png("1954a.png")
par(mfrow=c(3,1))
with(d1@data$average,
    {
        oce.plot.ts(time, magnetometerx)
        oce.plot.ts(time, magnetometery)
        oce.plot.ts(time, magnetometerz)
    })
if (!interactive())
    dev.off()

