rm(list=ls())
if (!interactive()) png("516B.png", width=700, height=700, pointsize=11)
library(oce)
try({
    source("~/src/oce/R/imagep.R")
})
library(oce)

data(coastlineWorld)
data(topoWorld)
par(mfrow=c(2,1), mar=c(1, 1, 2, 1))
mapPlot(coastlineWorld)
mapImage(topoWorld, breaks=seq(-2000, 2000, 500))
mtext(paste('EXPECT: colors NOT clipped to c(-2000, 2000) using breaks'), col=6, font=2)
mapPlot(coastlineWorld)
mapImage(topoWorld, zlim=c(-2000, 2000))
mtext(paste('EXPECT: identical to above'), col=6, font=2)

if (!interactive()) dev.off()

