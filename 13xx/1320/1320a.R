library(oce)
data(coastlineWorld)
coastlineWorld <- coastlineCut(coastlineWorld, -45)
p <- "+proj=aeqd +lon_0=-45"
if (!interactive()) png("1320a.png")
par(mar=c(2, 2, 1, 1))
## par(xpd=NA)
mapPlot(coastlineWorld, projection=p, col="lightgray",
        longitudelim=c(-80,0), latitudelim=c(0,79))

## EXPERIMENT looking at a point that is cut off (for some plot
## geometries). "i" is just a point I found by clicking with locator(),
## and imin:imax is the coastline sequence holding this point.
lon <- coastlineWorld[["longitude"]]
lat <- coastlineWorld[["latitude"]]
xy <- rgdal::project(cbind(lon, lat), proj=p)
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

