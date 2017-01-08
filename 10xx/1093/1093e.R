library(oce)
f <- "~/sentinelADCP/NLIW.pd0"
from <- 200000                         # skip 200K profiles
system.time({
    d <- read.oce(f, from=from, to=from+200, by=10, testing=TRUE)
})
summary(d)
if (!interactive()) png("1093d.png")
plot(toEnu(d))
if (!interactive()) dev.off()

