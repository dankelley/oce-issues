library(oce)
data(section)
sg <- sectionGrid(section)
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

## 1. start of section, default fields.
plot(head(section))
## 2. Gulf Stream
GS <- subset(section, 109<=stationId&stationId<=129)
GSg <- sectionGrid(GS, p=seq(0, 2000, 100))
plot(GSg, which=c(1, 99), map.ylim=c(34, 42))
par(mfrow=c(2, 1))
plot(GS, which=1, ylim=c(2000, 0), ztype='points',
     zbreaks=seq(0,30,2), pch=20, cex=3)
plot(GSg, which=1, ztype='image', zbreaks=seq(0,30,2))
