library(oce)
data(coastlineWorld)
if (!interactive()) pdf("09.pdf", width=7, height=7, pointsize=8)
par(mfrow=c(2,1), mar=c(2, 2, 1, 1), mgp=c(2, 0.7, 0))
xlim <- ylim <- NULL # yields identical map scales on successive pages
for (lon_0 in seq(-180, 180, 10)) {
    proj <- "robin"
    mod <- coastlineCut(coastlineWorld, lon_0=lon_0)
    lon <- mod[["longitude"]]
    lat <- mod[["latitude"]]
    plot(lon, lat, xlim=c(-180,180), ylim=c(-90,90), type='l')
    lines(c(-180, 180, 180, -180, -180), c(-90, -90, 90, 90, -90), col='gray')
    polygon(lon, lat, col='gray')
    proj <- sprintf("+proj=%s +lon_0=%.0f", proj, lon_0)
    if (is.null(xlim)) {
        mapPlot(mod, fill='gray', proj=proj)
        xlim <- par('usr')[1:2]
        ylim <- par('usr')[3:4]
    } else {
        mapPlot(mod, fill='gray', proj=proj, xlim=xlim, ylim=ylim, xaxs="i", yaxs="i")
    }
    mtext("BUG: opposite-edge 'shadow'", line=0, col='magenta', font=2, adj=0)
    mtext(proj, side=3, line=0, adj=1)
}
if (!interactive()) dev.off()
