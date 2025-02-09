library(oce)
f <- "/Users/kelley/git/oar_book/data/sample.rsk"
d <- read.oce(f)
summary(d)
ctd <- as.ctd(salinity = d[["salinity"]], temperature = d[["temperature"]], pressure = d[["pressure"]])
plot(ctd, which = 1, eos = "unesco")
summary(d)
if (!interactive()) png("562.png")
plot(ctd, which = 1, eos = "unesco")
mtext(" EXPECT: plot with levels, maybe a calibration", font = 2, col = "purple", line = -1, adj = 0)
if (!interactive()) dev.off()
