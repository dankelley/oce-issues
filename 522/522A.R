library(oce)
try({
    source('~/src/oce/R/map.R')
})
data(coastlineWorld)
data(topoWorld)

if (!interactive()) png('522A.png', width=600, height=200, type='cairo', pointsize=12)
par(mfrow=c(1,2), mar=c(2, 2, 1, 1))

lonlim <- c(-53.5,-50)
latlim <- c(41.5,45)
topo <- decimate(topoWorld, by=2) # coarse to illustrate filled contours
topo <- subset(topo, latlim[1] < latitude & latitude < latlim[2])
topo <- subset(topo, lonlim[1] < longitude & longitude < lonlim[2])
breaks <- seq(-2000, 0, 100)
cm <- colormap(col=oceColorsGebco, breaks=breaks, missingColor='red') # no need for z argument

## panel a
mapPlot(coastlineWorld, type='l',
        longitudelim=lonlim, latitudelim=latlim,
        proj="+proj=poly", grid=TRUE)
mapImage(topo, col=oceColorsGebco, breaks=breaks, missingColor='red')
mapLines(coastlineWorld)
mtext('(a)', adj=1)
box()

# panel b
mapPlot(coastlineWorld, type='l',
        longitudelim=lonlim, latitudelim=latlim,
        proj="+proj=poly", grid=TRUE)
mapImage(topo, colormap=cm)
mtext('(b)', adj=1)
mtext('EXPECT: as (a), no red spot in centre', col=6, font=2, adj=0)
box()
mapLines(coastlineWorld)


if (!interactive()) dev.off()
