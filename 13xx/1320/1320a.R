library(oce)
data(coastlineWorld)
p <- "+proj=aitoff +lon_0=-45"
if (!interactive()) png("1320a.png")
par(mar=c(2, 2, 1, 1))
par(xpd=NA)
mapPlot(coastlineWorld, projection=p, col="lightgray",
        longitudelim=c(-80,0), latitudelim=c(0,79))
if (!interactive()) dev.off()

