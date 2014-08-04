library(oce)
data(topoWorld)
#topoWorld <- decimate(topoWorld, by=3) # speed plotting 10X
topoWorld <- decimate(topoWorld, by=4) # speed plotting 10X
data(coastlineWorld)
source('~/src/oce/R/colors.R')
source('~/src/oce/R/map.R')

lim <- 1000

if (!interactive()) png('517A.png', width=800, height=450, type='cairo')
par(mfrow=c(2,2), mar=c(1,1,1.5,1))
##par(mfrow=c(2,1), mar=c(1,1,1.5,1))

mapPlot(coastlineWorld)
mapImage(topoWorld, col=oceColorsPalette, breaks=seq(-lim, lim, 10))
mtext(sprintf('EXPECT: solid blue < %.0f; solid red > %.0f', -lim, lim),
      font=2, col=6, adj=0)
mtext('(a) ', adj=1)

mapPlot(coastlineWorld)
mapImage(topoWorld, col=oceColorsPalette, breaks=seq(-lim, lim, 10), zclip=TRUE, missingColor = 'grey')
mtext(sprintf('EXPECT: grey if abs(z) > %.0f', lim), font=2, col=6, adj=0)
mtext('(b) ', adj=1)


cm <- colormap(topoWorld[['z']], col=oceColorsPalette, breaks=seq(-lim, lim, 10), debug=10)
mapPlot(coastlineWorld)
mapImage(topoWorld, colormap=cm, debug=10)
mtext('EXPECT: same as (a)', font=2, col=6, adj=0)
mtext('(c) ', adj=1)

cm <- colormap(topoWorld[['z']], col=oceColorsPalette, breaks=seq(-lim, lim, 10), zclip=TRUE, debug=10)
mapPlot(coastlineWorld)
mapImage(topoWorld, colormap=cm, debug=10)
mtext('EXPECT: same as (b)', font=2, col=6, adj=0)
mtext('(d) ', adj=1)


if (!interactive()) dev.off()

