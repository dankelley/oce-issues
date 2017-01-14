if (!interactive()) png("537B.png")
library(oce)
try({
    source("~/src/oce/R/map.R")
})
data(coastlineWorld)
mapPlot(coastlineWorld, projection="mollweide")
mapLines(coastlineWorld, col='red')
mtext("EXPECT: mapLines() without ugly horizontal lines", font=2, col="purple", adj=0)
if (!interactive()) dev.off()

