library(oce)
data(section)
GS <- subset(section, 109<=stationId&stationId<=129)
GSg <- sectionGrid(GS, p=seq(0, 2000, 100), debug=3)
stations <- GSg[["station"]]

for (istation in seq_along(stations)) {
    message("station ", istation)
    station <- stations[[istation]]
    print(station)
    expect_true(is.finite(station[["temperature"]][1]))
    message("  temperature is OK")
    expect_true(is.finite(station[["salinity"]][1]))
    message("  salinity is OK")
}

par(mfrow=c(2, 1))
plot(GS, which=1, ylim=c(2000, 0), ztype='points',
     zbreaks=seq(0,30,2), pch=20, cex=3)
plot(GSg, which=1, ztype='image', zbreaks=seq(0,30,2))

