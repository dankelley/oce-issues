p <- "+proj=ortho"
library(oce)
source("fake_south_pole.R")
data(coastlineWorld)
if (!interactive()) png("616c.png")
par(mfrow=c(2,2), mar=c(3, 3, 2, 1), mgp=c(2, 0.7, 0))
mapPlot(coastlineWorld, col="gray", axes=FALSE, projection=p)
lon <- coastlineWorld[["longitude"]]
lat <- coastlineWorld[["latitude"]]
cllon <- lon
cllat <- lat
aa <- lat < -60
n <- length(lat)
F <- -89
LL <- fakeSouthPole(lon, lat, pole=F)
lon <- LL$lon
lat <- LL$lat

## focus on Antarctica (for plot test)
aa <- lat < -60
alon <- lon[aa]
alat <- lat[aa]
xy <- lonlat2map(alon, alat, projection=p)
fake <- alat <= F & is.finite(alat)
plot(alon, alat, type='o', pch=0, cex=1/2, lwd=1/3)
points(alon[fake], alat[fake], col='red')

plot(xy$x, xy$y, type='l',asp=1)
polygon(xy$x, xy$y, col='gray')
points(xy$x[fake], xy$y[fake], col='red')
stop()

plot(diff(xy$x), diff(xy$y), type='l', asp=1)
cat("# fake South poles:", sum(fake, na.rm=TRUE), "\n")
data.frame(lon=alon[fake], lat=alat[fake], x=xy$x[fake], y=xy$y[fake])
if (!interactive()) dev.off()
