## further test panels a and c from 517Bdk.R
library(oce)
try({
    source('~/src/oce/R/map.R')
})
data(coastlineWorld)
data(topoWorld)

if (!interactive()) png('517C.png', width=700, height=300, type='cairo', pointsize=13)
par(mfrow=c(1,2), mar=c(2, 2, 3, 1))


## Original test
lonlim <- c(-70,-50)
latlim <- c(40,50)

## Tests to zero in on pixel so I can check it
lonlim <- c(-65,-59.5)
latlim <- c(45.5,48)

#topo <- decimate(topoWorld, by=2) # coarse to illustrate filled contours
topo <- subset(topoWorld, latlim[1] < latitude & latitude < latlim[2])
topo <- subset(topo, (360+lonlim[1]) < longitude & longitude < (360+lonlim[2]))
breaks <- seq(-2000, 0, 100)
col <- oceColorsGebco
cm <- colormap(col=col, breaks=breaks, missingColor="red")

## panel a
mapPlot(coastlineWorld, type='l',
        longitudelim=lonlim, latitudelim=latlim,
        proj="polyconic", orientation=c(90,-60,0), grid=TRUE)
Z <- topo[['z']]
debug <- 11 # lots of debugging (colorized if interactive)
debug <- 0
mapImage(topo, col=col, breaks=breaks, debug=debug)
mapLines(coastlineWorld)

## panel b
mapPlot(coastlineWorld, type='l',
        longitudelim=lonlim, latitudelim=latlim,
        proj="polyconic", orientation=c(90,-60,0), grid=TRUE)
mapImage(topo, colormap=cm, debug=debug)
mapLines(coastlineWorld)

if (!interactive()) dev.off()
