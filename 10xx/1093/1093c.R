library(oce)
system.time({
d <- read.oce("~/sentinelADCP/NLIW.pd0", from=1, to=100, testing=TRUE)
})
summary(d)
if (!interactive()) png("1093c.png")
plot(d)
if (!interactive()) dev.off()

