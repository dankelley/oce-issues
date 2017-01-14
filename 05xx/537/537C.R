if (!interactive()) png("537C.png")
library(oce)
try({
    source("~/src/oce/R/map.R")
})
data(coastlineWorld)
mapPlot(coastlineWorld, projection="mollweide")
mapLines(coastlineWorld, col='red')
mtext("EXPECT: no axis at left", font=2, col="purple", adj=0)
if (!interactive()) dev.off()

