library(oce)
try({source('~/src/oce/R/map.R')})
data(coastlineWorld)

if (!interactive()) png("533A.png")
par(mfrow=c(2,2), mar=c(2, 2, 3, 1))
lonlim <- c(-180, 180)
latlim <- c(50+20, 130-20) # centre the pole

p <- '+proj=stere +lat_0=90'
mapPlot(coastlineWorld, longitudelim=lonlim, latitudelim=latlim,
        projection=p, fill='lightgray')
mtext(p, side=3, adj=1, cex=0.9)
mtext("EXPECT: grid + axes (auto)", font=2, col="purple", adj=0, line=1)

mapPlot(coastlineWorld, longitudelim=lonlim, latitudelim=latlim,
        projection=p, fill='lightgray', grid=FALSE, axes=FALSE)
mapGrid(10, 10, polarCircle=5)
mtext(p, side=3, adj=1, cex=0.9)
mapAxis(side=1)
mapAxis(side=2)
mtext("EXPECT: 10deg grid/axes", font=2, col="purple", adj=0, line=1)

lonlim <- c(-100, -50)
latlim <- c(30, 60)

p <- "+proj=lcc +lon_0=-100 +lat_1=30 +lat_2=65"
mapPlot(coastlineWorld, longitudelim=c(-130,-55), latitudelim=c(35,60),
        projection=p, fill='lightgray', axes=TRUE, grid=TRUE)
mtext(p, side=3, adj=1, cex=0.9)
mtext("EXPECT: auto grid/axes", font=2, col="purple", adj=0, line=1)

mapPlot(coastlineWorld, longitudelim=c(-130,-55), latitudelim=c(35,60),
        projection=p, fill='lightgray', axes=FALSE, grid=FALSE)
mapGrid(10, 10, polarCircle=5)
mapAxis(side=1)
mapAxis(side=2)
mtext(p, side=3, adj=, cex=0.9)
mtext("EXPECT: 10 deg grid/axes", font=2, col="purple", adj=0, line=1)

if (!interactive()) dev.off()
