## idea: add a little to longitude and measure xy departure
if (!interactive()) pdf("388E.pdf", pointsize=9)
par(mfrow=c(2,2), mgp=c(2, 0.7, 0), mar=c(3, 3, 2, 1))
library(oce)
library(proj4)
data(coastlineWorld)
longitude <- coastlineWorld[["longitude"]]
latitude <- coastlineWorld[["latitude"]]

useOce <- TRUE                         # need to use oce to catch errors in mercator case

analyze <- function(proj, a=1000e3, dlon=1)
{
    if (useOce) {
        xy <- lonlat2map(longitude, latitude, proj=proj)
        xy2 <- lonlat2map(longitude+dlon, latitude, proj=proj)
        bad <- a < abs(xy$x-xy2$x)
        plot(xy$x, xy$y, type='l', asp=1)
        points(xy$x[bad], xy$y[bad], col='red')
    } else {
        xy <- project(cbind(longitude, latitude), proj=proj)
        xy2 <- project(cbind(longitude+dlon, latitude), proj=proj)
        bad <- a < abs(xy[,1]-xy2[,1])
        plot(xy, type='l', asp=1)
        points(xy[,1][bad], xy[,2][bad], col='red')
    }
}

analyze("+proj=moll")
analyze("+proj=moll +lon_0=-60")
analyze("+proj=merc")
analyze("+proj=merc +lon_0=-60")

if (!interactive()) dev.off()

