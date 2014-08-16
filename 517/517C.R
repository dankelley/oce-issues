## further test panels a and c from 517Bdk.R
library(oce)
try({
    source('~/src/oce/R/map.R')
})
data(coastlineWorld)
data(topoWorld)

if (!interactive()) png('517C.png', width=700, height=500, type='cairo', pointsize=13)
par(mfrow=c(1,2), mar=c(2, 2, 3, 1))


lonlim <- c(-70,-50)
latlim <- c(40,50)
#topo <- decimate(topoWorld, by=2) # coarse to illustrate filled contours
topo <- subset(topo, latlim[1] < latitude & latitude < latlim[2])
topo <- subset(topo, (360+lonlim[1]) < longitude & longitude < (360+lonlim[2]))
breaks <- seq(-2000, 0, 100)
cm <- colormap(col=oceColorsGebco, breaks=breaks, missingColor="red")

## panel a
mapPlot(coastlineWorld, type='l',
        longitudelim=lonlim, latitudelim=latlim,
        proj="polyconic", orientation=c(90,-60,0), grid=TRUE)
mapImage(topo, col=oceColorsGebco, breaks=breaks)
mapLines(coastlineWorld)
mtext('(a)', adj=1)
mtext("!filledContour ; col ; breaks", line=1, adj=0)
box()

## panel b
mapPlot(coastlineWorld, type='l',
        longitudelim=lonlim, latitudelim=latlim,
        proj="polyconic", orientation=c(90,-60,0), grid=TRUE)
mapImage(topo, colormap=cm)
mtext('(b)', adj=1)
mtext('EXPECT: as (a)', col=6, font=2, adj=0)
mtext('CHECK: central NB and Glace Bay', col=6, font=2, adj=0, line=1)
mtext("!filledContour ; colormap", line=2, adj=0)
box()
mapLines(coastlineWorld)

if (!interactive()) dev.off()
