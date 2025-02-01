library(oce)
# Test with multi-profile file
file <- "44687"
xbts <- read.xbt.noaa2(file)
if (!interactive()) {
    png("2289f_%02d.png")
}
lapply(xbts, \(xbt) {
    plot(xbt)
    mtext(sprintf(
        "%.4fN %.4fE %s", xbt[["latitude"]], xbt[["longitude"]],
        xbt[["time"]]
    ), line = -1)
})
lon <- sapply(xbts, \(xbt) xbt[["longitude"]])
lat <- sapply(xbts, \(xbt) xbt[["latitude"]])
par(mar = c(3, 3, 1, 1))
plot(lon, lat, asp = 1 / cos(mean(range(lat)) * pi / 180))
if (!interactive()) {
    dev.off()
}
