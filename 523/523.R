if (!interactive()) png("523.png", height=250)
library(oce)
try({
    source("~/src/oce/R/map.R")
})
data(coastlineWorld)
par(mar=c(1, 1, 1, 1))
mapPlot(coastlineWorld, proj="+proj=moll")
mtext("EXPECT: map of world, without spurious horiz lines", font=2, col='purple', adj=0)
if (!interactive()) dev.off()

