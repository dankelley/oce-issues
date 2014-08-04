library(oce)
data(topoWorld)
topoWorld <- decimate(topoWorld, by=5) # speed plotting 25X
data(coastlineWorld)
try({
    source('~/src/oce/R/colors.R')
    source('~/src/oce/R/map.R')
})

if (!interactive()) png('517Adk.png', width=1000, height=700, type='cairo')
par(mfrow=c(2,2), mar=c(2,2,1,1))

mapPlot(coastlineWorld)
mapImage(topoWorld, col=oceColorsJet, breaks=seq(-2000, 2000, 500))
mtext('EXPECT: dark blue < -2000 dark red > 2000', col=6, font=2)
mtext('(a)', adj=1)

mapPlot(coastlineWorld)
mapImage(topoWorld, col=oceColorsJet, breaks=seq(-2000, 2000, 500), zclip=TRUE,
         missingColor = 'grey')
mtext('EXPECT: grey for abs(z) > 2000', col=6, font=2)
mtext('(b)', adj=1)

cm <- colormap(topoWorld[['z']], col=oceColorsJet, breaks=seq(-2000, 2000, 500))
mapPlot(coastlineWorld)
mapImage(topoWorld, colormap=cm)
mtext('EXPECT: same as (a) above', col=6, font=2)
mtext('(c)', adj=1)

cm <- colormap(topoWorld[['z']], col=oceColorsJet, breaks=seq(-2000, 2000, 500),
               zclip=TRUE)
mapPlot(coastlineWorld)
mapImage(topoWorld, colormap=cm, debug=10)
mtext('EXPECT: same as (b) above', col=6, font=2)
mtext('(d)', adj=1)

if (!interactive()) dev.off()

