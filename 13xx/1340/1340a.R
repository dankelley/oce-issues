library(oce)
## source("~/git/oce/R/map.R")
data(coastlineWorld)

## generate a vector for a grid of points on the Earth
lo <- seq(-180, 180, 1)
la <- seq(-90, 90, 1)
lon <- expand.grid(lo, la)[,1]
lat <- expand.grid(lo, la)[,2]

SA <- array(gsw_SA_from_SP(rep(35, length(lon)),
                           rep(100, length(lon)), lon, lat),
            dim=c(length(lo), length(la)))

if (!interactive()) png('1340a_%d.png', width=5.5, height=3, unit="in", res=150, type='cairo')

par(mar=rep(1, 4))
p <- "+proj=moll"
p <- "+proj=lonlat"

mapPlot(coastlineWorld, projection=p)
mapImage(lo, la, SA, missingColor=NA, debug=0)
mapLines(coastlineWorld, col='gray')

mapPlot(coastlineWorld, projection=p)
options("dan"=1);mapImage(lo, la, SA, missingColor=NA, col=oceColorsJet, debug=0) # bad
options("dan"=2);mapImage(lo, la, SA, missingColor=NA, col=oceColorsJet, debug=0) # bad
mapLines(coastlineWorld, col='gray')

## does it help to specify breaks?
mapPlot(coastlineWorld, projection=p)
mapImage(lo, la, SA, missingColor=NA, breaks=128/4, col=oceColorsJet, debug=0) # ok
mapLines(coastlineWorld, col='gray')


if (!interactive()) dev.off()
