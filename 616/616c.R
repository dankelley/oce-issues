p <- "+proj=ortho"
library(oce)
try(source("~/src/oce/R/map.R"))
source("fake_south_pole.R")
data(coastlineWorld)
par(mfrow=c(2,2), mar=c(3, 3, 2, 1), mgp=c(2, 0.7, 0))
mapPlot(coastlineWorld, fill="gray", axes=FALSE, projection=p)
lon <- coastlineWorld[["longitude"]]
lat <- coastlineWorld[["latitude"]]
aa <- lat < -60
n <- length(lat)
LL <- fakeSouthPole(lon, lat)
lon <- LL$lon
lat <- LL$lat

## focus on Antarctica (for plot test)
aa <- lat < -60
alon <- lon[aa]
alat <- lat[aa]
xy <- lonlat2map(alon, alat, projection=p)
fake <- alat < -89.5 & is.finite(alat)
plot(alon, alat, type='o', pch=0, cex=1/2, lwd=1/3)
points(alon[fake], alat[fake], col='red')

plot(xy$x, xy$y, type='l',asp=1)
points(xy$x[fake], xy$y[fake], col='red')
plot(diff(xy$x), diff(xy$y), type='l', asp=1)
cat("# fake South poles:", sum(fake, na.rm=TRUE), "\n")
data.frame(lon=alon[fake], lat=alat[fake], x=xy$x[fake], y=xy$y[fake])
