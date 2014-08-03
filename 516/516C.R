rm(list=ls())
if (!interactive()) png("516C.png", width=700, height=400, pointsize=11)
library(oce)
try({
    source("~/src/oce/R/map.R")
    source("~/src/oce/R/imagep.R")
})
## library(oce)

data(coastlineWorld)
data(topoWorld)
par(mfrow=c(2,2), mar=c(1, 1, 2, 1))

mapPlot(coastlineWorld)
mapImage(topoWorld, breaks=seq(-2000, 2000, 500), debug=3)
mtext(paste('EXPECT: deep=blue, mountain=red-brown'), col=6, font=2)
mtext('(a) ', line=-1.2, adj=1)

mapPlot(coastlineWorld)
mapImage(topoWorld, zlim=c(-2000, 2000))
mtext(paste('EXPECT: as (a) but different color transitions'), col=6, font=2)
mtext('(b) ', line=-1.2, adj=1)

imagep(topoWorld, breaks=seq(-2000, 2000, 500), debug=3)
mtext(paste('EXPECT: same as (a) but not projected'), col=6, font=2)
mtext('(c) ', line=-1.2, adj=1)

imagep(topoWorld, zlim=c(-2000, 2000))
mtext(paste('EXPECT: as (c) but not projected'), col=6, font=2)
mtext('(d) ', line=-1.2, adj=1)

if (!interactive()) dev.off()

