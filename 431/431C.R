library(oce)
data(topoWorld)

cm1 <- colormapAlpha(name='gmt_relief')
cm2 <- colormapAlpha(file='http://www.beamreach.org/maps/gmt/share/cpt/GMT_globe.cpt')

if (!interactive()) png("431C.png")
par(mfrow=c(2,1))
c <- colorizeAlpha(colormap=cm1)
imagep(topoWorld, breaks=c$breaks, col=c$col)
c <- colorizeAlpha(colormap=cm2)
imagep(topoWorld, breaks=c$breaks, col=c$col)
if (!interactive()) dev.off()

