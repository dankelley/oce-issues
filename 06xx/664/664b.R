## fake data and local loads ... latter only work for developers
library(oce)
##system("R CMD SHLIB coastline2.c")
##dyn.load("coastline2.so")
##source("~/src/oce/R/coastline.R")
##source("~/src/oce/R/map.R")
lon <- -70 + 5 * cos(seq(0, 2*pi, length.out=8))
lat <- 10 + 5 * sin(seq(0, 2*pi, length.out=8))
lonlim <- c(-80, -60)
latlim <- c(5, 15)
cl <- as.coastline(lon, lat)
clc <- coastlineCut(cl, lon_0=-50)
if (!interactive()) png("664b.png", height=3, width=7, unit="in", res=100, pointsize=9)
par(mfrow=c(1, 2), mar=c(2, 2, 1, 1))
mapPlot(cl, proj="+proj=lcca +lat_0=20 +lon_0=-70",
        grid=5, longitudelim=lonlim, latitudelim=latlim)
mapPlot(clc, proj="+proj=lcca +lat_0=20 +lon_0=-70",
        grid=5, longitudelim=lonlim, latitudelim=latlim)
if (!interactive()) dev.off()
