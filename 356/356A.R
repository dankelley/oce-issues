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
    fi <- interp(lo, la, fv, seq(min(lo), max(lo), length.out=n), seq(min(la), max(la), length.out=n))

    nbreaks <- length(breaks)
    col <- col(nbreaks-1)
    zlim <- range(breaks)
    levels <- seq(zlim[1], zlim[2], length.out=nbreaks)

    mapImage(fi, col=col, zlim=zlim)
    mapContour(fi$x, fi$y, fi$z, levels=breaks[-nbreaks][-1], col=col, lwd=2, ...)
    if (contour) mapContour(fi$x, fi$y, fi$z, levels=breaks[-nbreaks][-1], col=ccol, lwd=clwd, ...)
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

breaks <- seq(-5000, 5000, 500)
par(mar=c(3, 3, 1, 1))

drawPalette(breaks, col=oceColorsJet(length(breaks)-1), zlab=expression(group('[', m, ']')))
mapPlot(coastlineWorld, latitudelim=latlim, longitudelim=lonlim, projection = 'stereographic', orientation =c(90, 0, -50))
mapFilledContour(lon, lat, z, breaks=breaks, contour=TRUE, col=oceColorsJet)
## mapPolygon(coastlineWorld, col='grey')
box()

if (!interactive()) dev.off()
