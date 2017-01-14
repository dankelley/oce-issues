rm(list=ls())
library(oce)
library(ocedata)
data(coastlineWorld)
data(coastlineWorldFine)
data(topoWorld)

if (!interactive()) png('708a.png')

par(mar=rep(2, 4))
mapPlot(coastlineWorldFine, fill='grey',
        longitudelim = c(-75, -50), latitudelim = c(35, 55),
        proj='+proj=wintri')
mapContour(topoWorld, levels=-250, lwd=2, col=2)

if (!interactive()) dev.off()
