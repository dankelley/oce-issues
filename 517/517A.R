library(oce)
try(source("~/src/oce/R/map.R"))
data(topoWorld)
data(coastlineWorld)
## source('~/src/R-richards/oce/R/colors.R')
## source('~/src/R-richards/oce/R/map.R')

## prefer cairo, but that fails with R as of July 2015 ... perhaps a fix is in the works?
##if (!interactive()) png('517A.png', width=1000, height=700, type='cairo')
if (!interactive()) png('517A.png', width=1000, height=700)
par(mfrow=c(2,2), mar=c(2,2,1,1))

mapPlot(coastlineWorld)
mapImage(topoWorld, col=oceColorsJet, breaks=seq(-2000, 2000, 500))
mtext('EXPECT: dark blue < -2000 dark red > 2000', col=6)
mtext('(a)', adj=1)

mapPlot(coastlineWorld)
mapImage(topoWorld, col=oceColorsJet, breaks=seq(-2000, 2000, 500), zclip=TRUE, missingColor = 'grey')
mtext('EXPECT: grey for abs(z) > 2000', col=6)
mtext('(b)', adj=1)

cm <- colormap(topoWorld[['z']], col=oceColorsJet, breaks=seq(-2000, 2000, 500), debug=10)
mapPlot(coastlineWorld)
mapImage(topoWorld, colormap=cm, debug=10)
mtext('EXPECT: same as (a)', col=6)
mtext('(c)', adj=1)

cm <- colormap(topoWorld[['z']], col=oceColorsJet, breaks=seq(-2000, 2000, 500), zclip=TRUE, debug=10)
mapPlot(coastlineWorld)
mapImage(topoWorld, colormap=cm, debug=10)
mtext('EXPECT: same as (b)', col=6)
mtext('(d)', adj=1)


if (!interactive()) dev.off()
