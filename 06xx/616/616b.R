library(oce)
source("fake_south_pole.R")
par(mfrow=c(2,2), mar=c(3, 3, 2, 1), mgp=c(2, 0.7, 0))
data(coastlineWorld)
mapPlot(coastlineWorld, col="gray", axes=FALSE, projection="+proj=ortho")
lon <- coastlineWorld[["longitude"]]
lat <- coastlineWorld[["latitude"]]
aa <- lat < -60
n <- length(lat)
plot(lon[aa], lat[aa], type='l')

## spi = south-pole indices
spi <- which(lat < -89.999)
points(lon[spi], lat[spi], col='red', pch=20)
mtext(paste("spi:", paste(spi, collapse=",  ")))
lat1 <- lat[1:spi[1]]
lon1 <- lon[1:spi[1]]
lat2 <- lat[spi[2]:n]
lon2 <- lon[spi[2]:n]
lines(lon1, lat1, col='green')
lines(lon2, lat2, col='red')
np <- 10 # number of fake south-pole points
LL <- fakeSouthPole(lon, lat)
LON <- LL$lon
LAT <- LL$lat

AA <- LAT < -60
plot(LON[AA], LAT[AA], type='o')

cl <- as.coastline(LON, LAT)
mapPlot(cl, col="gray", axes=FALSE, projection="+proj=ortho")
