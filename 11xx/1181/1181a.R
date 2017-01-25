## mapPolygon() not plotting coastline object correctly #1181
## clayton33

library(oce)
library(ocedata)
source("~/git/oce/R/map.R")
data(coastlineWorldFine)

cl <- as.coastline(longitude = c(NA, -45.819, -45.881, - 45.842, -45.842, -45.780, NA, 
                                 -46.100, -46.302, -46.302, -46.100, NA, -46.620, -46.653, -45.212,
                                 -45.149, -45.455, -46.142),
                   latitude = c(NA, 47.048, 47.048, 47.196, 47.359, 47.358, NA, 45.819, 45.819, 
                                   45.996, 45.996, NA, 48.314, 48.353, 49.002, 48.941, 48.827, 48.480))

latlim <- c(46,49)
lonlim <- c(-47,-44)

if (!interactive()) png("1181a.png")

par(mfrow=c(1,3))
plot(coastlineWorldFine, clatitude= 47.5, clongitude= -45.5, span=700, mar=c(2,2,1,1))
polygon(cl[['longitude']], cl[['latitude']], col='grey')

mapPlot(coastlineWorldFine, latitudelim = latlim, longitudelim=lonlim, 
               proj="+proj=merc", col='lightgray')

options(oce1181=TRUE)
mapPolygon(cl[['longitude']], cl[['latitude']], col='lightgray')

mapPlot(coastlineWorldFine, latitudelim = latlim, longitudelim=lonlim, 
               proj="+proj=merc", col='lightgray')
xy <- lonlat2map(cl[['longitude']], cl[['latitude']])
polygon(xy$x, xy$y, col='grey')

mtext("EXPECT: identical patches", font=2, col="magenta")

if (!interactive()) dev.off()
