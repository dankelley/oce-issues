library(oce)
data(coastlineWorld)
if (!interactive()) png("1306a.png", width=4, height=7, unit="in", res=150, pointsize=10)
par(mar=c(3, 3, 1, 1))
mapPlot(coastlineCut(coastlineWorld, -50),
         longitudelim=c(-100,5), latitudelim=c(35, 120),
         projection="+proj=lcc +lat_0=60 +lat_1=80 +lon_0=-50", col='gray')
if (!interactive()) dev.off()

