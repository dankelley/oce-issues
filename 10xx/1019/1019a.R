library(oce)
data(coastlineWorld)
if (!interactive()) png("1019a.png")
par(mfrow=c(2,1), mar=c(2, 2, 1, 1))
mapPlot(coastlineWorld, longitudelim=c(-130,-55), latitudelim=c(40,60),
         projection="+proj=lcc +lat_0=30 +lat_1=60 +lon_0=-100", col='gray')
mapPlot(coastlineWorld, longitudelim=c(-130,-55), latitudelim=c(40,60),
         projection="+proj=lcc +lat_0=30 +lat_1=60 +lon_0=-100", col='gray',
         cex.axis=1.4, mgp=c(0,0.7,0))

if (!interactive()) dev.off()

