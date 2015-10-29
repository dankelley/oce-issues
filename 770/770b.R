rm(list=ls())
library(oce)
data(section)
lon <- section[["longitude", "byStation"]]
lat <- section[["latitude", "byStation"]]
lonR <- lon[1]
latR <- lat[1]


NEWgeodXy <- function(lon, lat, lon.ref, lat.ref, rotate=0)
{
    PROJ <- "+proj=merc"
    xy <- rgdal::project(cbind(lon, lat), proj=PROJ, inv=FALSE)
    x <- xy[,1]
    y <- xy[,2]
    if (!missing(lon.ref) && !missing(lat.ref)) {
        xy.ref <- rgdal::project(cbind(lon.ref, lat.ref), proj=PROJ, inv=FALSE)
        x <- x - xy.ref[,1]
        y <- y - xy.ref[,2]
    }
    data.frame(x=x, y=y)
}
NEWgeodLonLat <- function(x, y, lon.ref, lat.ref)
{
    PROJ <- "+proj=merc"
    if (!missing(lon.ref) && !missing(lat.ref)) {
        xy.ref <- rgdal::project(cbind(lon.ref, lat.ref), proj=PROJ)
        x <- x + xy.ref[,1]
        y <- y + xy.ref[,2]
    }
    lonlat <- rgdal::project(cbind(x, y), proj=PROJ, inv=TRUE)
    data.frame(longitude=lonlat[,1], latitude=lonlat[,2])
}

if (!interactive()) png("770b.png")
par(mfrow=c(3,1), mar=c(3.5, 3, 1, 1), mgp=c(2, 0.7, 0))
plot(lon, lat)
XY <- NEWgeodXy(lon, lat, lonR, latR)
LONLAT <- NEWgeodLonLat(XY$x, XY$y, lonR, latR)
plot(XY$x, XY$y)
plot(LONLAT$longitude, LONLAT$latitude)
points(lon, lat, pch=3)
lonErr <- sqrt(mean((lon-LONLAT$longitude)^2))
latErr <- sqrt(mean((lat-LONLAT$latitude)^2))
mtext(sprintf("lonErr=%.1e, latErr=%.1e", lonErr, latErr), side=3, line=0, cex=3/4)

library(testthat)
## Whoa, these tests can be amazingly precise ... rgdal is impressive!
expect_less_than(lonErr, 1e-12)
expect_less_than(latErr, 1e-12)

if (!interactive()) dev.off()

