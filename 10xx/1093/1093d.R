library(oce)
system.time({
d <- read.oce("~/sentinelADCP/NLIW.pd0", from=10000, to=10100, testing=TRUE)
})
summary(d)
if (!interactive()) png("1093d.png")
plot(d)
if (!interactive()) dev.off()

