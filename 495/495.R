if (!interactive()) png("495.png")
library(oce)
data(coastlineWorld)
mapPlot(coastlineWorld, longitudelim=c(-130,-55), latitudelim=c(35,60),
        proj="lambert", parameters=c(lat0=40,lat1=60),
        orientation=c(90,-100,0))
lon <- seq(-120, -60, 10)
n <- length(lon)
lat <- 45 + rep(0, n)
mapArrows(lon, lat, lon, lat+15, length=0.05, col='blue')
if (!interactive()) dev.off()
