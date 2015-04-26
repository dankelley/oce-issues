library(oce)
try(source("~/src/oce/R/map.R"))
data(coastlineWorld)
data(topoWorld)
if (!interactive()) png("638a.png")
par(mfrow=c(2,1), mar=c(2, 2, 1, 1))
lonlim <- c(-70,-50)
latlim <- c(40,50)
topo <- decimate(topoWorld, by=2) # coarse to illustrate filled contours
topo <- subset(topo, latlim[1] < latitude & latitude < latlim[2])
topo <- subset(topo, (360+lonlim[1]) < longitude & longitude < (360+lonlim[2]))
mapPlot(coastlineWorld, type='l',
        longitudelim=lonlim, latitudelim=latlim,
        proj="+proj=poly +lon_0=-60", orientation=c(90,-60,0), grid=TRUE)
breaks <- seq(-2000, 0, 100)
mapImage(topo, col=oceColorsGebco, breaks=breaks)
mapLines(coastlineWorld)

mapPlot(coastlineWorld, type='l',
        longitudelim=lonlim, latitudelim=latlim,
        proj="polyconic", orientation=c(90,-60,0), grid=TRUE)
breaks <- seq(-2000, 0, 100)
mapImage(topo, col=oceColorsGebco, breaks=breaks)
mapLines(coastlineWorld)
mtext("EXPECT: same as other panel", font=2, col="purple", adj=0)

if (!interactive()) dev.off()
