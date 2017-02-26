library(oce)
data(coastlineWorld)
if (!interactive()) png('539B-%03d.png')
lons <- seq(179, -179, -10)
options(oceProj4Test=1)
ilon <- 1:3
ilon <- seq_along(lons)
par(mar=rep(1, 4), bg=NA)
for (i in ilon) {
    lon <- lons[i]
    p <- paste('+proj=ortho +lat_0=30 +lon_0=', lon, sep='')
    if (i == 1) {
        mapPlot(coastlineWorld, projection=p)
        xlim <- par("usr")[1:2]
        ylim <- par("usr")[3:4]
    } else {
        mapPlot(coastlineWorld, projection=p, xlim=xlim, ylim=ylim, xaxs="i", yaxs="i")
    }
    mapPoints(0, 90, col='red')
}
mtext("EXPECT: poles at same spot", font=2, col="purple", adj=0)
if (!interactive()) dev.off()
