if (!interactive()) png("368.png", width=7, height=7, unit="in", res=150, pointsize=8)

library(oce)
par(mfrow=c(3,2), mar=c(3, 3, 2, 1))
lonlim <- c(-20, 20)
latlim <- c(55, 75)

d <- list(lon=seq(-20, 20, length.out=5),
          lat=seq(60, 69, length.out=10),
          z=matrix(1:5, nrow=5, ncol=10))
dt <- list(lon=seq(-20, 20, length.out=5),
           lat=seq(60, 69, length.out=10),
           z=t(matrix(1:10, nrow=10, ncol=5)))
contour(d$lon, d$lat, d$z)
mtext("EXPECT: equi-spaced contours", font=2, line=0.5, col="magenta", adj=0)
mtext("(a) ", font=2, line=0.5, adj=1)
contour(dt$lon, dt$lat, dt$z)
mtext("EXPECT: equi-spaced contours", font=2, line=0.5, col="magenta", adj=0)
mtext("(b) ", font=2, line=0.5, adj=1)

col <- rainbow(5)
image(d$lon, d$lat, d$z, col=col)
mtext("EXPECT: equi-spaced colours", font=2, line=0.5, col="magenta", adj=0)
mtext("(c) ", font=2, line=0.5, adj=1)
image(dt$lon, dt$lat, dt$z, col=col)
mtext("EXPECT: equi-spaced colours", font=2, line=0.5, col="magenta", adj=0)
mtext("(d) ", font=2, line=0.5, adj=1)

data(coastlineWorld)
mapPlot(coastlineWorld, longitudelim=lonlim, latitudelim=latlim, projection='+proj=stere')
mapImage(d$lon, d$lat, d$z, col=col, zlim=c(0,6))
mapLines(coastlineWorld)
mtext("EXPECT: as (c) but projected", side=3, line=0.5, font=2, col="magenta", adj=0)
mtext("(e) ", font=2, line=0.5, adj=1)

mapPlot(coastlineWorld, longitudelim=lonlim, latitudelim=latlim, projection='+proj=stere')
mapImage(dt$lon, dt$lat, dt$z, col=col, zlim=c(0,11))
mapLines(coastlineWorld)
mtext("EXPECT: as (d) but projected", side=3, line=0.5, font=2, col="magenta", adj=0)
mtext("(f) ", font=2, line=0.5, adj=1)

if (FALSE) {
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
}

if (!interactive()) dev.off()
