library(oce)
data(section)
GS <- subset(section, 109<=stationId&stationId<=129)
GSg <- sectionGrid(GS, p=seq(0, 2000, 100), debug=3, method="approxML")
stations <- GSg[["station"]]

for (istation in seq_along(stations)) {
    cat("station ", istation, "\n")
    station <- stations[[istation]]
    expect_true(is.finite(station[["temperature"]][1]))
    expect_true(is.finite(station[["salinity"]][1]))
    cat("  ... top level is non-NA, so this station passes the test\n")
}

if (!interactive()) png("1472a.png")
par(mfrow=c(2, 1))
plot(GS, which=1, ylim=c(2000, 0), ztype='points',
     zbreaks=seq(0,30,2), pch=20, cex=2)
plot(GSg, which=1, ztype='image', zbreaks=seq(0,30,2))
if (!interactive()) dev.off()
