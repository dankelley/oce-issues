message("655b.R is 517Bdk.R, moved here for simplicity of checking")
library(oce)
data(coastlineWorld)
data(topoWorld)

if (!interactive()) png('655b.png', width=700, height=700, type='cairo', pointsize=12)
par(mfrow=c(2,2), mar=c(2, 2, 1, 1))


lonlim <- c(-70,-50)
latlim <- c(40,50)
topo <- subset(topoWorld, latlim[1] < latitude & latitude < latlim[2])
topo <- subset(topo, lonlim[1] < longitude & longitude < lonlim[2])
breaks <- seq(-2000, 0, 100)
col <- oceColorsGebco

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
cm <- colormap(col=col, breaks=breaks, missingColor="red")
str(cm)
mapImage(topo, colormap=cm, debug=3)
mtext('(c)', adj=1)
mtext('EXPECT: as (a) with no red', col=6, font=2, adj=0)
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
