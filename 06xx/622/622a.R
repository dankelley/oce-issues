library(oce)
d <- read.oce("a.rsk")
trim <- function(data, parameters) parameters[1] < data$scan & data$scan < parameters[2]
dt <- ctdTrim(d, trim, parameters=c(3800, 4300))
if (!interactive()) png("622a_%d.png")
plot(dt)
plot(ctdTrim(d))
if (!interactive()) dev.off()

