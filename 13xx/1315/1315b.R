LOOK <- 4575:4707 # NA to NA on Greenland
library(oce)
data(coastlineWorld)
if (!interactive()) png("1315b.png", width=7, height=7, unit="in", res=150, pointsize=9)
par(mfrow=c(2,2), mar=c(3, 3, 2, 1), mgp=c(2, 0.7, 0))

lon<-coastlineWorld[["longitude"]]
lat<-coastlineWorld[["latitude"]]
ll<-cbind(lon, lat)
library(rgdal)
xy <- project(ll, "+proj=stere +lat_0=-90")

x <- xy[,1]
y <- xy[,2]
clLOOK <- .Call("map_clip_xy", x[LOOK], y[LOOK], c(-3e6,3e6,-3e6,3e6))
cl <- .Call("map_clip_xy", x, y, c(-3e6,3e6,-3e6,3e6))

L <- 3.4e6
plot(xy[,1], xy[,2], xlim=L*c(-1, 1), ylim=L*c(-1,1), asp=1, type="l")
abline(h=0, col='blue')
abline(v=0, col='blue')
lines(xy[LOOK,1], xy[LOOK,2], col=2)
polygon(xy[LOOK,1], xy[LOOK,2], col='lightgreen')
points(xy[LOOK[1]+1,1], xy[LOOK[1]+1,2], col='red') # first point
mtext("(a)", side=3, line=0, adj=1, col='magenta', font=2)

L <- 4000e3
mapPlot(coastlineWorld, proj="+proj=stere +lat_0=-90", col='lightgray', clip=TRUE, xlim=c(-L, L), ylim=c(-L, L))
mapLines(lon, lat, col=2)
mapLines(lon[LOOK], lat[LOOK], col=3)
mapPoints(lon[LOOK[1]+1], lat[LOOK[1]+1], col='red') # first point
mtext("(b)", side=3, line=0, adj=1, col='magenta', font=2)

wild<-xy[,2]>1e22
plot(xy[!wild,1], xy[!wild,2], type='l')
polygon(xy[!wild,1], xy[!wild,2],col='lightgray')
lines(xy[!wild,1], xy[!wild,2])
points(xy[LOOK,1], xy[LOOK,2], col=2)
mtext("(c)", side=3, line=0, adj=1, col='magenta', font=2)

mapPlot(coastlineWorld, proj="+proj=stere +lat_0=-90", col='lightgray', clip=FALSE,
        latitudelim=c(-200, -60), longitudelim=c(-260, 10))
mtext("(d)", side=3, line=0, adj=1, col='magenta', font=2)

if (!interactive()) dev.off()
