library(oce)
data(coastlineWorld)
if (!interactive()) png("974a.png")
par(mfrow=c(2,2), mar=c(2, 2, 1, 1))
mapPlot(coastlineWorld, longitudelim=c(-180,180), latitudelim=c(70,110),
        proj="+proj=stere +lat_0=90", col='gray')
mapPlot(coastlineWorld, longitudelim=c(-130,50), latitudelim=c(70,110),
        proj="+proj=stere +lat_0=90", col='gray')
mapPlot(coastlineWorld, longitudelim=c(-130,50), latitudelim=c(70,110),
        proj="+proj=stere +lat_0=90 +lon_0=-135", col='gray')
mapPlot(coastlineWorld, longitudelim=c(-180,180),latitudelim=c(70,110),
        proj="+proj=stere +lat_0=90 +lon_0=135", col='gray')
if (!interactive()) dev.off()

