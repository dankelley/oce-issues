library(oce)
data(topoWorld)

cm <- colormapAlpha(file='http://www.beamreach.org/maps/gmt/share/cpt/GMT_globe.cpt')

if (!interactive()) png("431C.png")
par(mar=c(3, 3, 1, 1))
imagep(topoWorld, breaks=cm$breaks, col=cm$col)
if (!interactive()) dev.off()

