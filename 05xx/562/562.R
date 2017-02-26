library(oce)
d <- read.oce("~/Downloads/RSKtools/sample.rsk")
if (!interactive()) png("562.png")
plot(d, which=1)
mtext(" EXPECT: plot with levels, maybe a calibration", font=2, col="purple", line=-1, adj=0)
if (!interactive()) dev.off()

