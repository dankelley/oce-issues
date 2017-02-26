library(oce)
data(coastlineWorld)
data(topoWorld)
if (!interactive()) png("638a.png")
par(mfrow=c(2,1), mar=c(2, 2, 1, 1))
lonlim <- c(-70,-50)
latlim <- c(40,50)
topo <- decimate(topoWorld, by=2) # coarse to illustrate filled contours
topo <- subset(topo, latlim[1] < latitude & latitude < latlim[2])
topo <- subset(topo, lonlim[1] < longitude & longitude < lonlim[2])
mapPlot(coastlineWorld, type='l',
        longitudelim=lonlim, latitudelim=latlim,
        proj="+proj=poly +lon_0=-60", grid=TRUE)
breaks <- seq(-2000, 0, 100)
mapImage(topo, col=oceColorsGebco, breaks=breaks)
mapLines(coastlineWorld)
mtext("(a) ", adj=1)

mapPlot(coastlineWorld, type='l',
        longitudelim=lonlim, latitudelim=latlim,
        proj="+proj=poly +lon_0=-60", grid=TRUE)
breaks <- seq(-2000, 0, 100)
mapImage(topo, col=oceColorsGebco, breaks=breaks)
mapLines(coastlineWorld)
mtext("(b) ", adj=1)
mtext("EXPECT: same as (a)", font=2, col="purple", adj=0)

if (!interactive()) dev.off()
