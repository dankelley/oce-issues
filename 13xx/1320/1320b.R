library(oce)
data(coastlineWorld)
coastlineWorld <- coastlineCut(coastlineWorld, -45)
p <- "+proj=aitoff +lon_0=-45"
## p <- "+proj=ortho +lon_0=-45"
if (!interactive()) png("1320b.png")
par(mar=c(2, 2, 2, 2))

#par(xpd=NA)
par(xpd=FALSE)

mapPlot(coastlineWorld, projection=p, col="lightgray",
        longitudelim=c(-80,0), latitudelim=c(0,79), debug=0)

lon <- coastlineWorld[["longitude"]]
lat <- coastlineWorld[["latitude"]]
xy <- rgdal::project(cbind(lon, lat), proj=p)

## EXPERIMENT looking at a point that is cut off (for some plot
## geometries). "i" is just a point I found by clicking with locator(),
## and imin:imax is the coastline sequence holding this point.
i <- which.min((xy[,1]-4081795)*(xy[,1]-4081795) + (xy[,2]-9461998)*(xy[,2]-9461998))
na <- which(is.na(lon))
imin <-  na[max(which(na<i))]
imax <- na[min(which(na>i))]
##message("i=", i, ", imin=", imin, ", imax=", imax)
ilook <- imin:imax
if (2 != sum(is.na(lon[ilook])))
    stop("ilook is messed up")
lines(xy[ilook, 1], xy[ilook, 2], col=2)
points(xy[ilook, 1], xy[ilook, 2], col=2, pch=20, cex=1/2)


if (!interactive()) dev.off()

## DK SCRATCHBOOK

## > length(lon)
## [1] 12517
 
## istart=0 iend=67
## lon[1+0:67] ... ok, all non-NA (NOTE: this first sequence has two NAs at end)
## istart=70 iend=135
## lon[1+70:135] ... ok, all non-NA
## istart=138 iend=145

## istart=12405 iend=12415
## istart=12418 iend=12477
## istart=12480 iend=12515
