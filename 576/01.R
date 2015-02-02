library(oce)
library(ocedata)
data(coastlineWorldMedium)
longitudelim <- c(-180,-125)
latitudelim <- c(45,55)

if (!interactive()) png('01.png')
par(mfrow=c(2, 2), mar=rep(2, 4))

for (llon in seq(-190, -160, 10)) {
    mapPlot(coastlineWorldMedium, longitudelim=c(llon, -120), latitudelim=latitudelim,
            proj="+proj=lcc +lat_0=40 +lat_1=60 +lon_0=-150",  grid=c(5, 5))
    mapGrid(longitude=-180, latitude=NULL, lwd=4, col=2)
}

if (!interactive()) dev.off()
