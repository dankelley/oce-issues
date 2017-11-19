library(oce)
data(coastlineWorld)

if (!interactive()) png("1319a_%d.png", pointsize=9)
par(mar=c(2, 2, 1, 1))

p <- "+proj=imw_p +lat_1=10 +lat_2=70 +lon_0=-40"
mapPlot(coastlineWorld, debug=3,
        projection=p, longitudelim=c(-80, 0), latitudelim=c(0, 70), col="lightgray")
mtext(p, line=0.25, adj=1, col=2, font=2)
mtext("without coastlineCut()", line=1.25, adj=1, col=2, font=2)

p <- "+proj=imw_p +lat_1=10 +lat_2=70 +lon_0=-40"
mapPlot(coastlineCut(coastlineWorld, -40),
        projection=p, longitudelim=c(-80, 0), latitudelim=c(0, 70), col="lightgray")
mtext(p, line=0.25, adj=1, col=2, font=2)
mtext("with coastlineCut()", line=1.25, adj=1, col=2, font=2)

if (!interactive()) dev.off()

