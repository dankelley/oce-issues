library(oce)
d <- read.oce("a.rsk", patm=FALSE)
stopifnot(min(d[["pressure"]]) > 5)
dt <- ctdTrim(d)
if (!interactive()) png("622b.png")
plot(dt)
if (!interactive()) dev.off()

