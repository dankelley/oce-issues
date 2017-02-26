library(oce)
if (!interactive()) png("631b.png")
data(coastlineWorldFine, package="ocedata")
par(mar=c(2, 2, 1, 1), mfrow=c(1,2))
mapPlot(coastlineWorldFine, grid=5, fill="gray",
        longitudelim=c(-5, 20), latitudelim=c(50, 66),
        projection="+proj=lcc +lat_1=50 +lat_2=65")
mapPlot(coastlineWorldFine, grid=5, fill="gray",
        longitudelim=c(-5, 20), latitudelim=c(50, 66),
        projection="+proj=lcc +lat_1=50 +lat_2=65")
mapPolygon(coastlineWorldFine, col='gray')
if (!interactive()) dev.off()

