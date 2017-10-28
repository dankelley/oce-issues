library(oce)
data(coastlineWorld)
if (!interactive()) png("1315a.png")
par(mfrow=c(2,2), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
plot(coastlineWorld, proj="+proj=stere +lat_0=90", col='lightgray',
     latitudelim=c(60, 120), longitudelim=c(-130,-50))
lon<-coastlineWorld[["longitude"]]
lat<-coastlineWorld[["latitude"]]
ll<-cbind(lon, lat)
library(rgdal)
xy <- project(ll, "+proj=stere +lat_0=90")
wild<-xy[,2]>1e22
plot(xy[!wild,1], xy[!wild,2], type='l')
polygon(xy[!wild,1], xy[!wild,2],col='lightgray')
lines(xy[!wild,1], xy[!wild,2])

## sketch for issue report
xx <- c(0,0,1)
yy <- c(0,1,1)
plot(xx, yy, type='p', pch=20, cex=3, xlab="", ylab="")
polygon(xx, yy, col='lightgray')
polygon(c(0.4,.4,.8,.8),c(0.2, 0.5, 0.5, 0.2),border='blue',lwd=3)

if (!interactive()) dev.off()
