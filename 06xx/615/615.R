library(oce)
data(topoWorld)
if (!interactive()) png("615.png")
par(mfrow=c(2, 1))
plot(topoWorld, xlim=c(-120, 0), location="left")
mapPlot(topoWorld, proj="+proj=moll", levels=-2000)
if (!interactive()) dev.off()
