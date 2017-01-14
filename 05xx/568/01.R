library(oce)
dS <- read.oce("ADCP061_000000.ENS")
if (!interactive()) png("01.png")
data(coastlineWorldFine, package="ocedata")
plot(dS, which="map", coastline="coastlineWorldFine")
if (!interactive()) dev.off()

