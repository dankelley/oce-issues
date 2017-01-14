library(oce)
system.time(d <- read.oce("~/sentinelADCP/NLIW.pd0"))
summary(d)
if (!interactive()) png("1093d.png")
plot(toEnu(d))
if (!interactive()) dev.off()

