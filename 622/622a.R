library(oce)
d <- read.oce("a.rsk")
message("for some reason, ctdTrim() doesn't find the downcast")
trim <- function(data, parameters) parameters[1] < data$scan & data$scan < parameters[2]
dt <- ctdTrim(d, trim, parameters=c(3800, 4300))
if (!interactive()) png("622a.png")
plot(dt)
if (!interactive()) dev.off()

