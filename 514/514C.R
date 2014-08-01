if (!interactive())
    png("514C.png", height=4, width=7, unit="in", res=150, pointsize=12)
library(oce)
try({
    source('~/src/oce/R/map.R')
})
data(coastlineWorld)

par(mar=c(4, 4, 2, 1), mgp=c(2,0.7,0), mfrow=c(1,2))
xy <- mapproject(0, 0, projection="mollweide")
n <- 100
eps <- 1e-4
lon <- runif(n, -180+eps, 180-eps)
lat <- runif(n, -90+eps, 90-eps)
xy <- mapproject(lon, lat)
LONLAT <- map2lonlat(xy$x, xy$y)
plot(lon, LONLAT$longitude)
mtext(sprintf("RMS: %.1f", sqrt(mean((lon-LONLAT$longitude)^2, na.rm=TRUE))))
abline(0,1)
plot(lat, LONLAT$latitude)
mtext(sprintf("RMS: %.1f", sqrt(mean((lat-LONLAT$latitude)^2, na.rm=TRUE))))
abline(0,1)
if (!interactive()) dev.off()

