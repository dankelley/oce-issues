library(oce)
data(coastlineWorld)
cl <- coastlineCut(coastlineWorld, lon_0=-75)
if (!interactive()) png("664.png", height=3, width=7, unit="in", res=100, pointsize=9)
par(mfrow=c(1, 2), mar=c(2, 2, 1, 1))
lonlim <- c(-90, -70)
latlim <- c(15, 20)
mapPlot(coastlineWorld, proj="+proj=lcca +lat_0=20 +lon_0=-75",
        grid=5, longitudelim=lonlim, latitudelim=latlim)
mapPlot(cl, proj="+proj=lcca +lat_0=20 +lon_0=-75",
        grid=5, longitudelim=lonlim, latitudelim=latlim)
if (!interactive()) dev.off()
