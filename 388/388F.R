rm(list=ls())
if (!interactive()) pdf("388F.pdf", height=4, pointsize=9)
par(mar=c(2, 2, 3, 1), mgp=c(2, 0.7, 0))

lon <- seq(-180,180,8)
proj <- "+proj=moll +lon_0=-60"
#proj <- "+proj=merc +lon_0=-60"
#proj <- "+proj=stere +lon_0=-60"
library(plyr)
library(proj4)
latitude <- seq(-90, 90, length.out=20)
#latitude <- seq(30, 80, 10)
n <- length(latitude)
longitude <- rep(0, n)
for (i in 1:n) {
    ## message("latitude: ", latitude[i])
    range <- 180
    ## 7 iterations yields +- 0.00256 deg or 256 m
    for (iteration in 1:7) {
        lon <- longitude[i] + seq(-range, range, length.out=10)
        x <- laply(lon, function(lon) project(cbind(lon,latitude[i]), proj=proj)[1,1])
        longitude[i] <- lon[which.max(abs(diff(x)))]
        ##message(" ", longitude[i], " +- ", diff(lon[1:2]))
        range <- range / 5
    }
}
summary(longitude)
LON <- longitude
LAT <- latitude
xy <- project(list(longitude=longitude, latitude=latitude), proj=proj)
D <- 0.1                               # trace LH side of globe (works on tests at 0.01)
xy2 <- project(list(longitude=longitude+D, latitude=latitude), proj=proj)
x <- c(xy$x, xy2$x)
y <- c(xy$y, rev(xy2$y))

library(oce)
data(coastlineWorld)
mapPlot(coastlineWorld, proj=proj)
lines(x, y, col='red')

if (!interactive()) dev.off()
