library(oce)
data(coastlineWorld)
if (!interactive()) png("579_a.png", width=500, height=300)
par(mar=rep(1, 4))
mapPlot(coastlineWorld,projection="+proj=hammer")
if (!interactive()) dev.off()

