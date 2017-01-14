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

mapDirectionField <- function(longitude, latitude,
                              u, v, scale=1, code=2, length=0.05,
                              col=par("fg"), lwd=par("lwd"))
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
    xy <- mapproject(longitude, latitude)
    ## Calculate spatially-dependent scale (fails for off-page points)
    ## Calculate lon-lat at ends of arrows
    scalex <- scale / cos(pi * latitude / 180)
    latEnd <- latitude + v * scale
    lonEnd <- longitude + u * scalex
    xy <- mapproject(longitude, latitude)
    xyEnd <- mapproject(lonEnd, latEnd)
    arrows(xy$x, xy$y, xyEnd$x, xyEnd$y, length=length, code=code, col=col)
}
mapDirectionField(lonm, latm, u, v, scale=3)
mapDirectionField(lonm, latm, 0, v, scale=3, col='red')
mapDirectionField(lonm, latm, u, 0, scale=3, col='blue')

if (!interactive()) dev.off()
