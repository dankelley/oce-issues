library(oce)
data(coastlineWorld)
col <- "lightgray"
##p <- "+proj=geos +h=35785831.0 +lon_0=-60 +sweep=y"
p <- "+proj=geos +h=35785831.0 +lon_0=-60"
#p <- "+proj=moll"
if (!interactive()) png("1338a.png")
par(mar=rep(1, 4))
mapPlot(coastlineWorld, projection=p, col=col)# debug=10)
message("mapPoints() works (but it should not)")
mapPoints(longitude=175, latitude=-40, pch=20, cex=2, col=2, debug=3) # in New Zealand

## nz <- cbind(175, -40) # in New Zealand
## xy <- rgdal::project(nz, proj=p)
## xy
## message("project() fails (as it should)")
## points(xy[1,1], xy[1,2], pch=20, cex=1, col=3)

if (!interactive()) dev.off()
