rm(list=ls())
if (!interactive()) png("516B.png", width=700, height=400, pointsize=11, type="cairo", antialias="none")
library(oce)
try({
    source("~/src/oce/R/map.R")
})
library(oce)

data(coastlineWorld)
data(topoWorld)
par(mfrow=c(2,2), mar=c(1, 1, 2, 1))

mapPlot(coastlineWorld)
mapImage(topoWorld, breaks=seq(-2000, 2000, 1000), debug=3)
mtext(paste('EXPECT: 1km colour banding'), col=6, font=2)
mtext('(a) ', line=-1.2, adj=1)

mapPlot(coastlineWorld)
mapImage(topoWorld, zlim=c(-2000, 2000))
mtext(paste('EXPECT: blending colours'), col=6, font=2)
mtext('(b) ', line=-1.2, adj=1)

mapPlot(coastlineWorld)
mapImage(topoWorld, zclip=TRUE, breaks=seq(-2000, 2000, 1000))
mtext(paste('EXPECT: as (a) but white for abs(z) > 2000'), col=6, font=2)
mtext('(c) ', line=-1.2, adj=1)

mapPlot(coastlineWorld)
mapImage(topoWorld, zclip=TRUE, zlim=c(-2000, 2000))
mtext(paste('EXPECT: as (b) but white for abs(z) > 2000'), col=6, font=2)
mtext('(d) ', line=-1.2, adj=1)

if (!interactive()) dev.off()

