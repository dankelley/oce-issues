set.seed(514)
if (!interactive())
    png("514C.png", height=5, width=5, unit="in", res=120, pointsize=8)
library(oce)
try({
    source('~/src/oce/R/map.R')
})

par(mar=c(3, 3, 2, 1), mgp=c(2,0.7,0), mfrow=c(2,2))
n <- 100
eps <- 1e-4
set.seed(514)
lon <- runif(n, -180+eps, 180-eps)
lat <- runif(n, -90+eps, 90-eps)
xy <- mapproject(lon, lat, projection="mollweide")
LONLAT <- map2lonlat(xy$x, xy$y)
Lon <- LONLAT$longitude
Lat <- LONLAT$latitude
D <- mean(abs(geodDist(lon, lat, Lon, Lat)), na.rm=TRUE) # km
col <- ifelse(abs(Lat) > 85, "red", "black")
plot(lon, LONLAT$longitude, col=col)
grid()
mtext("mapproj", adj=0)
mtext("RED if inferred abs(lat) > 85", line=-1, col='red', adj=0)
mtext(sprintf("mean(abs(distance)) %.1f km", D), adj=1)
abline(0,1)

plot(lat, LONLAT$latitude, col=col)
grid()
abline(0,1)
mtext("mapproj", adj=0)
mtext("RED if inferred abs(lat) > 85", line=-1, col='red', adj=0)
mtext(sprintf("mean(abs(distance)) %.1f km", D), adj=1)

xy <- project(list(longitude=lon, latitude=lat), proj="+proj=moll")
LONLAT <- project(xy, proj="+proj=moll", inverse=TRUE)
Lon <- LONLAT$x
Lat <- LONLAT$y
D <- mean(abs(geodDist(lon, lat, Lon, Lat)), na.rm=TRUE) # km
col <- ifelse(abs(Lat) > 85, "red", "black")
plot(lon, LONLAT$x, col=col)
grid()
mtext("proj4", adj=0)
mtext("RED if inferred abs(lat) > 85", line=-1, col='red', adj=0)
mtext(sprintf("mean(abs(distance)) %.1f km", D), adj=1)
abline(0,1)

plot(lat, LONLAT$y, col=col)
grid()
mtext("proj4", adj=0)
mtext("RED if inferred abs(lat) > 85", line=-1, col='red', adj=0)
mtext(sprintf("mean(abs(distance)) %.1f km", D), adj=1)
if (!interactive()) dev.off()

