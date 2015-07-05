library(oce)
try(source('~/src/oce/R/map.R'))
data(coastlineWorld)
data(topoWorld)

## prefer cairo, but that fails with R as of July 2015 ... perhaps a fix is in the works?
##if (!interactive()) png('517Bdk.png', width=700, height=700, type='cairo')
if (!interactive()) png('517Bdk.png', width=700, height=700)
par(mfrow=c(2,2), mar=c(2, 2, 1, 1))


lonlim <- c(-70,-50)
latlim <- c(40,50)
topo <- subset(topoWorld, latlim[1] < latitude & latitude < latlim[2])
topo <- subset(topo, (360+lonlim[1]) < longitude & longitude < (360+lonlim[2]))
breaks <- seq(-2000, 0, 100)
col <- oceColorsGebco
cm <- colormap(col=col, breaks=breaks, missingColor="red")

## panel a
mapPlot(coastlineWorld, type='l',
        longitudelim=lonlim, latitudelim=latlim,
        proj="+proj=poly +lon_0=-60", grid=TRUE)
mapImage(topo, col=oceColorsGebco, breaks=breaks)
mapLines(coastlineWorld)
mtext('(a)', adj=1)
box()

## panel b
mapPlot(coastlineWorld, type='l',
        longitudelim=lonlim, latitudelim=latlim,
        proj="+proj=poly +lon_0=-60", grid=TRUE)
mapImage(topo, filledContour=TRUE, col=oceColorsGebco, breaks=breaks)
mapLines(coastlineWorld)
mtext('EXPECT: as (a) but smooth color separators', col=6, font=2, adj=0)
mtext('(b)', adj=1)
box()

## panel c
mapPlot(coastlineWorld, type='l',
        longitudelim=lonlim, latitudelim=latlim,
        proj="+proj=poly +lon_0=-60", grid=TRUE)
mapImage(topo, colormap=cm)
mtext('(c)', adj=1)
mtext('EXPECT: as (a) above', col=6, font=2, adj=0)
box()
mapLines(coastlineWorld)

## panel d
mapPlot(coastlineWorld, type='l',
        longitudelim=lonlim, latitudelim=latlim,
        proj="+proj=poly +lon_0=-60", grid=TRUE)
mapImage(topo, filledContour=TRUE, colormap=cm)
mtext('(d)', adj=1)
mtext('EXPECT: as (b) above', col=6, font=2, adj=0)
box()
mapLines(coastlineWorld)



if (!interactive()) dev.off()
