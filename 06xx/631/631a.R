library(oce)
try(source("~/src/oce/R/map.R"))
if (!interactive()) png("631a.png")
data(coastlineWorld)
par(mar=c(2, 2, 1, 1), mfrow=c(1,2))
mapPlot(coastlineWorld, grid=5, fill="gray",
        longitudelim=c(-5, 20), latitudelim=c(50, 66),
        projection="+proj=lcc +lat_1=50 +lat_2=65")
mapPlot(coastlineWorld, grid=5, fill="gray",
        longitudelim=c(-5, 20), latitudelim=c(50, 66),
        projection="+proj=lcc +lat_1=50 +lat_2=65")
mapPolygon(coastlineWorld, col='gray')
if (!interactive()) dev.off()

