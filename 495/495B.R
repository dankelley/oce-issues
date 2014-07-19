if (!interactive()) png("495B.png")
library(oce)
data(coastlineWorld)
par(mar=rep(2,4))
mapPlot(coastlineWorld, longitudelim=c(-130,-55), latitudelim=c(35,60),
        proj="lambert", parameters=c(lat0=40,lat1=60),
        orientation=c(90,-90,0))
lon <- seq(-120, -60, 15)
lat <- 45 + seq(-15, 15, 5)
lonm <- matrix(expand.grid(lon,lat)[,1], nrow=length(lon))
latm <- matrix(expand.grid(lon,lat)[,2], nrow=length(lon))
## vectors pointed 45 degrees clockwise from north
u <- matrix(1, nrow=length(lon), ncol=length(lat))
v <- matrix(1, nrow=length(lon), ncol=length(lat))

mapDirectionField <- function(longitude, latitude, u, v, scalex, scaley=1, type=2, length=0.05, add=TRUE) 
{
    ## handle case where lon and lat are coords on edges of grid
    if (is.matrix(u)) {
        if (is.vector(longitude) && is.vector(latitude)) {
            nlon <- length(longitude)
            nlat <- length(latitude)
            longitude <- matrix(rep(longitude, nlat), nrow=nlon)
            latitude <- matrix(rep(latitude, nlon), byrow=TRUE, nrow=nlon)
        }
    }
    if (!missing(scalex))
        warning("value of scalex is ignored")
    xy <- mapproject(longitude, latitude)
    ## Calculate spatially-dependent scale (fails for off-page points)
    eps <- diff(range(latitude, na.rm=TRUE)) / 200 + diff(range(longitude, na.rm=TRUE)) / 200
    dx <- mapproject(longitude+eps, latitude)$x - xy$x
    dx <- dx / cos(latitude * pi / 180)
    pi <- 4 * atan2(1, 1)
    dy <- mapproject(longitude, latitude+eps)$y - xy$y
    scalex <- scaley # FIXME: is this right?  Arrows are definitely wrong
    DX <- dx * u * scaley
    DY <- dy * v * scaley
    points(xy$x, xy$y, pch=21, bg='green')
    arrows(xy$x, xy$y, xy$x+DX, xy$y+DY, length=1/20)
}
#mapDirectionField(lonm, latm, u, v)
mapDirectionField(lon, lat, u, v, scaley=5)
message("FIXME: arrow angle to graticles erroneously depends on longitude")

if (!interactive()) dev.off()
