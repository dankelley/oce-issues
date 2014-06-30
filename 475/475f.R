if (!interactive()) png("475f.png")
library(oce)
try({
    source('~/src/oce/R/coastline.R')
    source('~/src/oce/R/map.R')
})
par(mar=rep(0, 4))
data(coastlineWorld)
mapPlot(coastlineWorld, type='l',
        proj='mollweide', drawBox=FALSE,)
data(endeavour, package='ocedata')
mapPoints(endeavour$longitude, endeavour$latitude,
          pch=20, cex=0.5)
if (!interactive()) dev.off()

