mapFilledContour <- function(lon, lat, f, breaks, n=500, contour=FALSE, clwd=1.25, ccol=1, col=oceColorsJet, ...)
{
    require(akima)
    fv <- as.vector(f)
    lo <- expand.grid(lon, lat)[,1]
    la <- expand.grid(lon, lat)[,2]
    good <- !is.na(fv)
    lo <- lo[good]
    la <- la[good]
    fv <- fv[good]
    rval <- system.time({fi <- interp(lo, la, fv, seq(min(lo), max(lo), length.out=n), seq(min(la), max(la), length.out=n))})

    nbreaks <- length(breaks)
    col <- col(nbreaks-1)
    zlim <- range(breaks)
    levels <- seq(zlim[1], zlim[2], length.out=nbreaks)

    mapImage(fi, col=col, zlim=zlim)
    if (contour) mapContour(fi$x, fi$y, fi$z, levels=breaks[-nbreaks][-1], col=ccol, lwd=clwd, ...)
    ## DK timing (laptop):
    ##     n   elapsed_time
    ##    22          0.066
    ##    50          0.065
    ##   100          0.070
    ##   200          0.069
    ##   300          0.077
    ##   400          0.086
    ##   500          0.094
    ##   600          0.111
    ##   700          0.123
    ##   800          0.143
    ##   900          0.162
    ##  1000          0.179
    rval 
}

### Test code for mapFilledContour()
library(oce)

data(coastlineWorld)
data(topoWorld)
lon <- topoWorld[['longitude']]
lat <- topoWorld[['latitude']]
z <- topoWorld[['z']]

## make lon go from -180 to 180
II <- lon > 180
lon[II] <- lon[II] - 360
lonlim <- c(-80, -50)
latlim <- c(30, 60)

## trim to smaller region
IIlon <- lonlim[1] <= lon & lon <= lonlim[2]
IIlat <- latlim[1] <= lat & lat <= latlim[2]
lon <- lon[IIlon]
lat <- lat[IIlat]
z <- z[IIlon, IIlat]

if (!interactive()) png('356A.png', type='cairo')

breaks <- seq(-5000, 1000, 500)
par(mar=c(3, 3, 5, 1))

drawPalette(breaks, col=oceColorsJet(length(breaks)-1), zlab=expression(group('[', m, ']')))
mapPlot(coastlineWorld, latitudelim=latlim, longitudelim=lonlim,
        projection='stereographic', orientation=c(90, 0, -50))
n <- 100
t <- mapFilledContour(lon, lat, z, breaks=breaks, n=n, contour=TRUE, col=oceColorsJet)
#t <- mapFilledContour(lon, lat, z, breaks=breaks, contour=TRUE, col=oceColorsJet)
## mapPolygon(coastlineWorld, col='grey')
box()
mtext("EXPECT: image colour breaks match contoured coastline [PASS]", font=2, col="purple", adj=0)
mtext("EXPECT: filled regions, not image-style boxes [PASS]", font=2, col="purple", adj=0, line=1)
mtext("EXPECT: interpolation in under 2s [PASS]", font=2, col="purple", adj=0, line=2)
mtext(sprintf("NB. interpolation took %.3fs for n=%d", t[[3]], n), line=3, adj=0)
mtext("356A.R: use mapImage() on interpolated field (CR method)", line=4, adj=0)
if (!interactive()) dev.off()
