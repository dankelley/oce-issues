library(oce)
try(source("~/src/oce/R/map.R"))
data(coastlineWorld)
if (!interactive()) png("546.png")
x <- 17266632
y <- 14745394
#try(source("~/src/oce/R/map.R"));map2lonlat(x, y, proj="+proj=wintri")
mapPlot(coastlineWorld, projection="+proj=wintri", fill="lightgray", debug=3)
if (!interactive()) dev.off()

