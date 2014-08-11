mfcCR <- function(lon, lat, f, breaks, n=500, contour=FALSE, clwd=1.25, ccol=1, col=oceColorsJet, ...)
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
    mapLines(coastlineWorld)
    ## if (contour) mapContour(fi$x, fi$y, fi$z, levels=breaks[-nbreaks][-1], col=ccol, lwd=clwd, ...)
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

mfcDK <- function(lon, lat, f, breaks, n=500, contour=FALSE, clwd=1.25, ccol=1, col=oceColorsJet, ...)
{
    require(akima)

    fv <- as.vector(f)
    lo <- expand.grid(lon, lat)[,1]
    la <- expand.grid(lon, lat)[,2]
    xy <- lonlat2map(lo, la)
    ## plot(xy$x, xy$y, asp=1, pch='.')
    ## "g" means gridded
    f <- 2 # grid increase factor
    xg <- seq(min(xy$x, na.rm=TRUE), max(xy$x, na.rm=TRUE), length.out=f*length(lon))
    yg <- seq(min(xy$y, na.rm=TRUE), max(xy$y, na.rm=TRUE), length.out=f*length(lat))

    good <- !is.na(fv)
    lo <- lo[good]
    la <- la[good]
    fv <- fv[good]
    fi <- interp(xy$x, xy$y, fv, xg, yg)

    nbreaks <- length(breaks)
    col <- col(nbreaks-1)
    zlim <- range(breaks)
    levels <- seq(zlim[1], zlim[2], length.out=nbreaks)
    levels <- breaks # FIXME: probably wrong
    .filled.contour(fi$x, fi$y, fi$z, levels=breaks,col=col)
    mapLines(coastlineWorld)
}

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

if (!interactive()) png('356C.png', width=7, height=3, unit="in", res=150, pointsize=8, type='cairo')

breaks <- seq(-8000, 1000, 500)
col <- oceColorsJet(length(breaks)-1)
par(mfrow=c(1,2))

par(mar=c(2, 2, 2, 1))
drawPalette(zlim=range(breaks), col=col, zlab=expression(group('[', m, ']')))
mapPlot(coastlineWorld, latitudelim=latlim, longitudelim=lonlim,
        projection='stereographic', orientation=c(90, 0, -50))
n <- 100
t <- mfcCR(lon, lat, z, breaks=breaks, n=n, contour=TRUE, col=oceColorsJet)
mtext("EXPECT: pixelated image", font=2, col="purple", adj=0)

par(mar=c(2, 2, 2, 1))
drawPalette(zlim=range(breaks), col=col, zlab=expression(group('[', m, ']')))
mapPlot(coastlineWorld, latitudelim=latlim, longitudelim=lonlim,
        projection='stereographic', orientation=c(90, 0, -50))
t <- mfcDK(lon, lat, z, breaks=breaks, n=n, contour=TRUE, col=oceColorsJet)
mtext("EXPECT: filled-contour (non pixelated)", font=2, col="purple", adj=0)

if (!interactive()) dev.off()
