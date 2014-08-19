## idea: add a little to longitude and measure xy departure
if (!interactive()) pdf("388E.pdf", height=6, pointsize=9)
par(mfrow=c(2,2), mgp=c(2, 0.7, 0), mar=c(2, 2, 1, 0.3))
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
        xy3 <- lonlat2map(longitude-dlon, latitude, proj=proj)
        plot(xy$x, xy$y, type='l', asp=1, xlab="", ylab="", col='darkgray')
        badR <- a < abs(xy$x-xy2$x)
        points(xy$x[badR], xy$y[badR], col='red')
        badL <- a < abs(xy$x-xy3$x)
        points(xy$x[badL], xy$y[badL], col='blue')
    } else {
        xy <- project(cbind(longitude, latitude), proj=proj)
        xy2 <- project(cbind(longitude+dlon, latitude), proj=proj)
        xy3 <- project(cbind(longitude-dlon, latitude), proj=proj)
        plot(xy, type='l', asp=1, xlab="", ylab="", col='darkgray')
        badR <- a < abs(xy[,1]-xy2[,1])
        points(xy[,1][badR], xy[,2][badR], col='red')
        badL <- a < abs(xy[,1]-xy3[,1])
        points(xy[,1][badL], xy[,2][badL], col='blue')
    }
    list(badR=badR, badL=badL)
}

b1 <- analyze("+proj=moll")
b2 <- analyze("+proj=moll +lon_0=-60")
b3 <- analyze("+proj=merc")
b4 <- analyze("+proj=merc +lon_0=-60")

if (!interactive()) dev.off()

