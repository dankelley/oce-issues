library(oce)
try({source('~/src/oce/R/map.R')})
data(coastlineWorld)
par(mfrow=c(2,1), mar=c(2, 2, 3, 1))
lonlim <- c(-180, 180)
latlim <- c(60, 120) # centre the pole

p <- '+proj=stere +lat_0=90'
mapPlot(coastlineWorld, projection=p, longitudelim=lonlim, latitudelim=latlim, grid=FALSE)
mapGrid(15, 15, polarCircle=1/2)
mtext(p, side=3, adj=1)
## mapAxis(side=1, debug=1)
                                        #mapAxis(side=1, lon=seq(-180, 180, 45)) # buggy labels
mapAxis(side=1, lat=seq(0, 90, 15), debug=1)
mapAxis(side=1, lon=c(-15, 0, 15, 30, 45), debug=1)

## mapAxis(side=c(1,3), debug=1)
mtext("EXPECT: no mess at dateline", font=2, col="purple", adj=0, line=2)
mtext("EXPECT: longitudes on all sides", font=2, col="purple", adj=0, line=1)

lonlim <- c(-100, -50)
latlim <- c(30, 60)

lonlim <- c(-100, -50)
latlim <- c(30, 60)


p <- "+proj=lcc +lon_0=-100"
mapPlot(coastlineWorld, longitudelim=c(-130,-55), latitudelim=c(35,60), projection=p)
mapGrid(15, 15, polarCircle=1/2)
mapAxis(side=1, debug=1)
mtext(p, side=3, adj=1)
