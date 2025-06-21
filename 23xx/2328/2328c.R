library(oce)
file <- "TEST_RUN_BOAT_DATA_3.cnv"
d <- read.oce(file)
summary(d)
if (!interactive()) png("2328c.png", units = "in", width = 7, height = 7, res = 200)
plot(d)
if (!interactive()) dev.off()
