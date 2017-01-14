library(oce)
from <- 200000                         # skip 200K profiles
system.time(d <- read.oce("~/sentinelADCP/NLIW.pd0", from=from, to=from+200))
summary(d)
if (!interactive()) png("1093d.png")
plot(toEnu(d))
if (!interactive()) dev.off()

