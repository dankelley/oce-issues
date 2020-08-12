library(oce)
data(coastlineWorld)
if (!interactive()) png("1721a.png")
##if (!interactive()) pdf("1721a.pdf")
par(mfrow=c(1, 2))
proj <- "+proj=stere +lat_0=75"
plot(coastlineWorld, projection=proj)
mtext(paste('plot,coastline-method', proj), cex=par("cex"))
mapPlot(coastlineWorld, projection=proj, proj)
mtext(paste('mapPlot', proj), cex=par("cex"))
if (!interactive()) dev.off()

