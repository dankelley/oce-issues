rm(list=ls())
library(oce)
library(ocedata)
data(coastlineWorldFine)

if (!interactive()) png('418A-%02d.png')

for (i in 1:5)  {
    drawPalette(c(0, 1))
    mapPlot(coastlineWorldFine, latitudelim = c(20, 60), longitudelim = c(-80, -40))
}

if (!interactive()) dev.off()
