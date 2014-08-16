## further test panels a and c from 517Bdk.R
library(oce)
try({
    source('~/src/oce/R/map.R')
})
data(coastlineWorld)
data(topoWorld)

if (!interactive()) png('517C.png', width=700, height=700, type='cairo', pointsize=12)
par(mfrow=c(2,2), mar=c(2, 2, 3, 1))

## Original test
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
        proj="polyconic", orientation=c(90,-62,0), grid=TRUE)
mapImage(topo, col=col, breaks=breaks)
mapLines(coastlineWorld)
mtext('(a)', adj=1)
mtext("mapImage w/ topo, col, breaks", adj=0, line=0)

## panel b
mapPlot(coastlineWorld, type='l',
        longitudelim=lonlim, latitudelim=latlim,
        proj="polyconic", orientation=c(90,-62,0), grid=TRUE)
mapImage(topo, colormap=cm)
mapLines(coastlineWorld)
mtext('(a)', adj=1)
mtext('EXPECT: as (a)', col=6, font=2, adj=0, line=1)
mtext("mapImage w/ colormap", adj=0, line=0)
## Bottom row: clipping
cm <- colormap(col=col, breaks=breaks, missingColor="red", zclip=TRUE)

## panel c
mapPlot(coastlineWorld, type='l',
        longitudelim=lonlim, latitudelim=latlim,
        proj="polyconic", orientation=c(90,-62,0), grid=TRUE)
Z <- topo[['z']]
mapImage(topo, col=col, breaks=breaks, zclip=TRUE, missingColor="red")
mapLines(coastlineWorld)
mtext('(c)', adj=1)
mtext("mapImage w/ topo, col, breaks, zclip=TRUE", adj=0, line=0)
mtext('EXPECT: red for z>0 or z<-2000', col=6, font=2, adj=0, line=1)

## panel d
mapPlot(coastlineWorld, type='l',
        longitudelim=lonlim, latitudelim=latlim,
        proj="polyconic", orientation=c(90,-62,0), grid=TRUE)
mapImage(topo, colormap=cm)
mapLines(coastlineWorld)
mtext('(d)', adj=1)
mtext("mapImage w/ colormap(..., zclip=TRUE)", adj=0, line=0)
mtext('EXPECT: as (c)', col=6, font=2, adj=0, line=1)

if (!interactive()) dev.off()

