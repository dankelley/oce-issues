rm(list=ls())
set.seed(514)
if (!interactive())
    png("514C.png", height=5, width=5, unit="in", res=120, pointsize=8)
library(oce)
library(proj4)
try({
    source('~/src/oce/R/map.R')
})

par(mar=c(2.5, 2.5, 2.5, 0.5), mgp=c(1.5,0.5,0), mfrow=c(3,2))
n <- 100
eps <- 1e-3
set.seed(514)
lon <- runif(n, -180+eps, 180-eps)
lat <- runif(n, -90+eps, 90-eps)
xy <- mapproject(lon, lat, projection="mollweide")
LONLAT <- map2lonlat(xy$x, xy$y)
Lon <- LONLAT$longitude
Lat <- LONLAT$latitude
col <- ifelse(abs(lat) > 85, "red", "black")

## Top row: mapproj
plot(lon, lon-Lon, col=col)
grid()
mtext("Expect: y=0 in each panel", font=2, line=1, col="purple", adj=0.5)
mtext("mapproj package", adj=0)
D <- mean(abs(geodDist(lon, lat, Lon, Lat)), na.rm=TRUE) # km
#mtext(sprintf(" MAD %.0f km", D), adj=1)

plot(lat, lat-Lat, col=col)
grid()
mtext("mapproj package", adj=0)

## Middle row: proj4 (external package)
xy <- project(list(longitude=lon, latitude=lat), proj="+proj=moll")
LONLAT <- project(xy, proj="+proj=moll", inverse=TRUE)
Lon <- LONLAT$x
Lat <- LONLAT$y
col <- ifelse(abs(Lat) > 85, "red", "black")
plot(lon, lon-Lon, col=col)
grid()
mtext("proj4 package", adj=0)
D <- mean(abs(geodDist(lon, lat, Lon, Lat)), na.rm=TRUE) # km
#mtext(sprintf("MAD %.2f km", D), adj=1)

plot(lat, lat-Lat, col=col)
grid()
mtext("proj4 package", adj=0)


## Bottom row: internal PROJ.4
n <- length(lon)
XY <- .C("proj4_interface", as.character("+proj=moll +ellps=sphere"), as.integer(TRUE),
                     as.integer(n), as.double(lon), as.double(lat),
                     X=double(n), Y=double(n), NAOK=TRUE)
ll <- .C("proj4_interface", as.character("+proj=moll +ellps=sphere"), as.integer(FALSE),
                     as.integer(n), as.double(XY$X), as.double(XY$Y),
                     X=double(n), Y=double(n), NAOK=TRUE)
plot(lon, lon-ll$X, col=col)
D <- mean(abs(geodDist(lon, lat, ll$X, ll$Y)), na.rm=TRUE) # km
#mtext(sprintf(" MAD %.2f km", D), adj=1)
grid()
mtext("PROJ.4 (supplied by oce)", adj=0)

plot(lat, lat-ll$Y, col=col)
D <- mean(abs(geodDist(lon, lat, ll$X, ll$Y)), na.rm=TRUE) # km
grid()
mtext("PROJ.4 (supplied by oce)", line=0, adj=0)

if (!interactive()) dev.off()

