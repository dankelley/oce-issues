if (!interactive()) png("523.png")
library(oce)
try({
    source("~/src/oce/R/map.R")
})
data(coastlineWorld)
mapPlot(coastlineWorld, proj="+proj=moll")
if (!interactive()) dev.off()

