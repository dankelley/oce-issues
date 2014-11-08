library(oce)
try({source("~/src/oce/R/map.R")})
data(coastlineWorld)
if (!interactive()) png("541.png")
mapPlot(coastlineWorld)
if (!interactive()) dev.off()

