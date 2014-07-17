if (!interactive()) pdf("388A.pdf", pointsize=9)
library(oce)
library(mapproj)
library(proj4)
data(coastlineWorld)
lon <- coastlineWorld[['longitude']]
lat <- coastlineWorld[['latitude']]


par(mfrow=c(2,2), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
xy <- project(cbind(lon,lat), "+proj=moll")
plot(xy[,1], xy[,2], type='l', asp=1)
mtext("proj4", side=3, font=2, col='purple', line=-1.5)

xy <- mapproject(coastlineWorld[['longitude']], coastlineWorld[['latitude']], proj="mollweide")
plot(xy$x, xy$y, type='l', asp=1)
mtext("mapproj", side=3, font=2, col='purple', line=-1.5)

d <- sqrt(diff(xy$x)^2 + diff(xy$y)^2)
h <- hist(log10(d), plot=FALSE, breaks=1000)
plot(h$mids, h$count, type='l')
mtext("mapproj log10(distance)", side=3, font=2, col='purple', line=-1.5)
boxplot(log10(d), ylab="log10(d)")

if (!interactive()) dev.off()
