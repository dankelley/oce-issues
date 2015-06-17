if (!interactive()) png("368.png", width=7, height=7, unit="in", res=150, pointsize=8)

library(oce)
par(mfrow=c(5,2), mar=c(3, 3, 1, 1))
lonlim <- c(-20, 20)
latlim <- c(55, 75)

d <- list(lon=seq(-20, 20, length.out=5),
          lat=seq(60, 69, length.out=10),
          z=matrix(1:5, nrow=5, ncol=10))
dt <- list(lon=seq(-20, 20, length.out=5),
           lat=seq(60, 69, length.out=10),
           z=t(matrix(1:10, nrow=10, ncol=5)))
contour(d$lon, d$lat, d$z)
mtext("EXPECT: once, the 3rd row was wrong", font=2, col="purple")
contour(dt$lon, dt$lat, dt$z)

col <- rainbow(5)
image(d$lon, d$lat, d$z, col=col)
image(dt$lon, dt$lat, dt$z, col=col)

data(coastlineWorld)
mapPlot(coastlineWorld, longitudelim=lonlim, latitudelim=latlim, projection='+proj=stere')
mtext("reference d", side=3, adj=1, line=0.5)
mapImage(d$lon, d$lat, d$z, col=col, zlim=c(0,6))
mapLines(coastlineWorld)

mapPlot(coastlineWorld, longitudelim=lonlim, latitudelim=latlim, projection='+proj=stere')
mtext("reference dt", side=3, adj=1, line=0.5)
mapImage(dt$lon, dt$lat, dt$z, col=col, zlim=c(0,11))
mapLines(coastlineWorld)

mapPlot(coastlineWorld, longitudelim=lonlim, latitudelim=latlim, projection='+proj=stere')
mapImage(d$lon, d$lat, d$z, col=col, zlim=c(0,6), debug=99)
mapLines(coastlineWorld)

mapPlot(coastlineWorld, longitudelim=lonlim, latitudelim=latlim, projection='+proj=stere')
mapImage(dt$lon, dt$lat, dt$z, col=col, zlim=c(0,11), debug=99)
mapLines(coastlineWorld)

mapPlot(coastlineWorld, longitudelim=lonlim, latitudelim=latlim, projection='+proj=stere')
mtext("debug=99", side=3, adj=1, line=0.5)
mapImage(d$lon, d$lat, d$z, col=col, debug=99)
mapLines(coastlineWorld)

mapPlot(coastlineWorld, longitudelim=lonlim, latitudelim=latlim, projection='+proj=stere')
mtext("debug=99", side=3, adj=1, line=0.5)
mapImage(dt$lon, dt$lat, dt$z, col=col, debug=99)
mapLines(coastlineWorld)

if (!interactive()) dev.off()
