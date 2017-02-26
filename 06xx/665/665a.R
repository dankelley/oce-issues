library(oce)
data(coastlineWorld)
if (!interactive()) png("665a.png", pointsize=9)
par(mfrow=c(1,2), mar=c(2, 2, 1, 1))
lonlim <- c(-90, -70)
latlim <- c(15, 20)
mapPlot(coastlineWorld, proj="+proj=lcca +lat_0=20 +lon_0=-75",
        longitudelim=lonlim, latitudelim=latlim)
mapPlot(coastlineWorld, proj="+proj=lcca +lat_0=20 +lon_0=-75",
        grid=5, longitudelim=lonlim, latitudelim=latlim)
if (!interactive()) dev.off()
