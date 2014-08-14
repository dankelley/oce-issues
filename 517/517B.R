library(oce)
data(coastlineWorld)
data(topoWorld)

if (!interactive()) png('517B.png', width=1000, height=700, type='cairo')
par(mfrow=c(2,1), mar=c(2, 2, 1, 1))
lonlim <- c(-70,-50)
latlim <- c(40,50)
topo <- decimate(topoWorld, by=2) # coarse to illustrate filled contours
topo <- subset(topo, latlim[1] < latitude & latitude < latlim[2])
topo <- subset(topo, (360+lonlim[1]) < longitude & longitude < (360+lonlim[2]))
mapPlot(coastlineWorld, type='l',
        longitudelim=lonlim, latitudelim=latlim,
        proj="polyconic", orientation=c(90,-60,0), grid=TRUE)
breaks <- seq(-2000, 0, 100)
mapImage(topo, col=oceColorsGebco, breaks=breaks)
mapLines(coastlineWorld)
box()
mapPlot(coastlineWorld, type='l',
        longitudelim=lonlim, latitudelim=latlim,
        proj="polyconic", orientation=c(90,-60,0), grid=TRUE)
cm <- colormap(topo[['z']], col=oceColorsGebco, breaks=breaks)
mapImage(topo, filledContour=TRUE, colormap=cm)
mtext('EXPECT: dark blue < -2000 light blue > 0 e.g. as above but with filled contours', col=6, font=2)
box()
mapLines(coastlineWorld)

if (!interactive()) dev.off()
