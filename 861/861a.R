library(oce)
try(source("~/src/oce/R/map.R"))
data(topoWorld)
data(coastlineWorld)
if (!interactive()) png("861a.png", height=300, width=700)
par(mfrow=c(1,2), mar=c(2, 2, 1, 1))
lonlim <- c(-70,-50)
latlim <- c(40,50)
topo <- decimate(topoWorld, by=2) # coarse to illustrate filled contours
topo <- subset(topo, latlim[1] < latitude & latitude < latlim[2])
topo <- subset(topo, lonlim[1] < longitude & longitude < lonlim[2])
mapPlot(coastlineWorld, type='l',
        longitudelim=lonlim, latitudelim=latlim,
        projection="+proj=lcc +lat_1=40 +lat_2=50 +lon_0=-60")
breaks <- seq(-5000, 1000, 500)
mapImage(topo, col=oce.colorsJet, breaks=breaks)
mapLines(coastlineWorld)
box()
mapPlot(coastlineWorld, type='l',
        longitudelim=lonlim, latitudelim=latlim,
        projection="+proj=lcc +lat_1=40 +lat_2=50 +lon_0=-60")
mapImage(topo, filledContour=TRUE, col=oce.colorsJet, breaks=breaks)
box()
mapLines(coastlineWorld)
if (!interactive()) dev.off()
