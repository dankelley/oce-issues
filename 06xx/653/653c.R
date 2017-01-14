if (!interactive()) png("653c.png")
library(oce)
data(coastlineWorld)
lon <- coastlineWorld[["longitude"]]
lat <- coastlineWorld[["latitude"]]
library(rgdal)
proj <- "+proj=ortho +ellps=sphere"

owarn <- options()$warn
options(warn=-1)
xy <- rgdal::project(cbind(lon,lat), proj)
ll <- rgdal::project(xy, proj, inv=TRUE)
options(warn=owarn)

#plot(xy[,1], xy[,2], asp=1, type='l')
par(mfrow=c(3,2))
mapPlot(coastlineWorld, proj=proj)
XY <- lonlat2map(lon, lat)
LL <- map2lonlat(XY$x, XY$y)
lines(XY$x, XY$y, col='red')
plot(XY$x, XY$y, asp=1, col='red', type='l')
hist((XY$x-xy[,1]))
hist((XY$y-xy[,2]))

hist((LL$longitude-ll[,1]))
hist((LL$latitude-ll[,2]))
if (!interactive()) dev.off()
