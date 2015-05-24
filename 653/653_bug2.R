library(oce)
source("~/src/oce/R/map.R")
data(coastlineWorldFine, package="ocedata")
if (!interactive()) png("653_bug2.png")
mapPlot(coastlineWorldFine, grid=5, fill="gray",
        longitudelim=c(-5, 20), latitudelim=c(50, 66),
        projection="+proj=lcc +lat_1=50 +lat_2=65", debug=0)
if (!interactive()) dev.off()

