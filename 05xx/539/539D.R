library(oce)
data(coastlineWorld)
if (!interactive()) pdf('539D-%03d.pdf')
lons <- seq(179, -179, -10)
ilon <- 1:3
ilon <- seq_along(lons)
for (i in ilon) {
    lon <- lons[i]
    par(mar=rep(1, 4))# , bg=NA)
    p <- paste('+proj=ortho +lat_0=30 +lon_0=', lon, sep='')
    if (i == 1) {
        mapPlot(coastlineWorld, projection=p)
        xlim <- par("usr")[1:2]
        ylim <- par("usr")[3:4]
    } else {
        mapPlot(coastlineWorld, projection=p, xlim=xlim, ylim=ylim, xaxs="i", yaxs="i")
    }
    mapPoints(0, 90, col='red', debug=99)
}
mtext("EXPECT: poles at same spot", font=2, col="purple", adj=0)
if (!interactive()) dev.off()

