library(oce)
file <- "TEST_RUN_BOAT_DATA_3.cnv"
d <- read.oce(file, missingValue = -9.99e-29)
summary(d)
if (!interactive()) png("2328b.png", units = "in", width = 7, height = 7, res = 200)
plot(d)
if (!interactive()) dev.off()
