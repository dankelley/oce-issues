rm(list=ls())
library(oce)
library(ocedata)
data(coastlineWorldFine)

if (!interactive()) {
    png('418B-%02d.png', width=1000, height=400)
} else {
    dev.new(width=10, height=4)
}

par(mfrow=c(1, 3))
for (i in 1:3)  {
    drawPalette(c(0, 1))
    mapPlot(coastlineWorldFine, latitudelim = c(20, 60), longitudelim = c(-80, -40))
}

if (!interactive()) dev.off()
