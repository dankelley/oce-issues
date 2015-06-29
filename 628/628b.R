library(oce)
#source("~/src/oce/R/map.R") # has temporary change to test wintri
sessionInfo()
if (!interactive()) png("628b.png")
data(coastlineWorld)
mapPlot(coastlineWorld, proj="+proj=wintri")
if (!interactive()) dev.off()
