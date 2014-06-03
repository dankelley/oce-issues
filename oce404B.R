library(oce)
source('~/src/R-kelley/oce/R/map.R')
library(ocedata)
data(coastlineWorld)
data(topoWorld)
d <- topoWorld[['z']][600:700, 200:300]
lon <- topoWorld[['longitude']][600:700]
lat <- topoWorld[['latitude']][200:300]

rlat <- rev(lat)    # reversed lat
rd <- d[,101:1]    # d reversed in the lat direction
par(mfrow=c(2,2))

## imagep and oceContour plots showing proper behaviour
imagep(lon, lat, d)
oceContour(lon, lat, d, add=TRUE)

imagep(lon, rlat, rd)
oceContour(lon, rlat, rd, add=TRUE)

## map proj plots showing how the reversed field doesn't contour properly
mapPlot(coastlineWorld, latitudelim=range(lat), longitudelim=range(lon))
mapImage(lon, lat, d)
mapContour(lon, lat, d)

mapPlot(coastlineWorld, latitudelim=range(lat), longitudelim=range(lon))
mapImage(lon, rlat, rd)
mapContour(lon, rlat, rd)
