library(oce)
library(gsw)
data(coastlineWorld)

## generate a vector for a grid of points on the Earth
lo <- seq(-180, 180, 1)
la <- seq(-90, 90, 1)
lon <- expand.grid(lo, la)[,1]
lat <- expand.grid(lo, la)[,2]

SA <- array(gsw_SA_from_SP(rep(35, length(lon)),
                           rep(100, length(lon)), lon, lat),
            dim=c(length(lo), length(la)))

if (!interactive()) png('1340a.png', height=300, type='cairo')

par(mar=rep(1, 4), mfrow=c(1, 2))

mapPlot(coastlineWorld, projection="+proj=moll")
mapImage(lo, la, SA, missingColor=NA)
mapLines(coastlineWorld, col='red')

mapPlot(coastlineWorld, projection="+proj=moll")
mapImage(lo, la, SA, missingColor=NA, col=oceColorsJet)
mapLines(coastlineWorld, col='red')


if (!interactive()) dev.off()
