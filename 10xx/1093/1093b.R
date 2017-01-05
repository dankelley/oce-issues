library(oce)
system.time({
d <- read.oce("~/sentinelADCP/NLIW_001.pd0", from=1, to=100, testing=TRUE)
})
summary(d)
if (!interactive()) png("1093b.png")
plot(d)
if (!interactive()) dev.off()

