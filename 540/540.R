library(oce)
try({source("~/src/oce/R/map.R")})
data(coastlineWorld)
if (!interactive()) pdf('539A-%03d.pdf')
#if (!interactive()) png('539A-%03d.png')
options(oceProj4Test=1)
lons <- seq(179, -179, -10)
ilon <- 1:3
for (i in ilon) {
    lon <- lons[i]
    par(mar=rep(1, 4), bg=NA)
    p <- paste('+proj=ortho +lat_0=30 +lon_0=', lon, sep='')
    if (i == 1) {
        mapPlot(coastlineWorld, projection=p)
        xlim <- par("usr")[1:2]
        ylim <- par("usr")[3:4]
    } else {
        mapPlot(coastlineWorld, projection=p, xlim=xlim, ylim=ylim, xaxs="i", yaxs="i")
    }
    mtext(paste("EXPECT: no coastline retracing", p), font=2, col="purple", adj=0)
}
if (!interactive()) dev.off()

