library(oce)
data(topoWorld)
topoWorld <- decimate(topoWorld, by=3) # speed plotting 10X
data(coastlineWorld)
source('~/src/oce/R/colors.R')
source('~/src/oce/R/map.R')

if (!interactive()) png('517A.png', width=1000, height=700, type='cairo')
par(mfrow=c(2,2), mar=c(2,2,1,1))

mapPlot(coastlineWorld)
mapImage(topoWorld, col=oceColorsPalette, breaks=seq(-2000, 2000, 10))
mtext('EXPECT: solid blue < -2000; solid red > 2000', font=2, col=6)
mtext('(a)', line=-1.2, adj=1, font=2)

mapPlot(coastlineWorld)
mapImage(topoWorld, col=oceColorsPalette, breaks=seq(-2000, 2000, 10), zclip=TRUE, missingColor = 'grey')
mtext('EXPECT: grey if abs(z) > 2000', font=2, col=6)
mtext('(b)', line=-1.2, adj=1, font=2)

cm <- colormap(topoWorld[['z']], col=oceColorsPalette, breaks=seq(-2000, 2000, 10), debug=10)
mapPlot(coastlineWorld)
mapImage(topoWorld, colormap=cm, debug=10)
mtext('EXPECT: same as (a)', font=2, col=6)
mtext('(c)', line=-1.2, adj=1, font=2)

cm <- colormap(topoWorld[['z']], col=oceColorsPalette, breaks=seq(-2000, 2000, 10), zclip=TRUE, debug=10)
mapPlot(coastlineWorld)
mapImage(topoWorld, colormap=cm, debug=10)
mtext('EXPECT: same as (b)', font=2, col=6)
mtext('(d)', line=-1.2, adj=1, font=2)

if (!interactive()) dev.off()

