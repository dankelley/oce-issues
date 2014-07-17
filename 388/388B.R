if (!interactive()) pdf("388B.pdf", pointsize=8)
## Row 1: mollweide (default)
## Row 2: mollweide (shifted to dateline)
showbad <- function(x, y, col='red', pch=16)
{
    span <- 0.5 * diff(range(x, na.rm=TRUE))
    dx <- c(0, diff(x))
    bad <- abs(dx) > span / 2
    bad[is.na(bad)] <- FALSE
    points(x[bad], y[bad], col=col, pch=pch)
    cat("span:", span, "\n")
}

library(oce)
library(proj4)
library(mapproj)
data(coastlineWorld)
lon <- coastlineWorld[['longitude']]
lat <- coastlineWorld[['latitude']]

par(mfrow=c(2,2), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0), cex=2/3)

xymapproj <- mapproject(lon, lat, proj="mollweide")
plot(xymapproj$x, xymapproj$y, type='l', asp=1)
showbad(xymapproj$x, xymapproj$y)
mtext("mapproj (old way)", side=3, font=2, col='purple', line=-1.5)

xyproj4 <- project(cbind(lon,lat), "+proj=moll")
plot(xyproj4[,1], xyproj4[,2], type='l', asp=1)
showbad(xyproj4[,1], xyproj4[,2])
mtext("proj4 (possible new way)", side=3, font=2, col='purple', line=-1.5)

## oriented with dateline at centre
xymapproj <- mapproject(lon, lat, proj="mollweide", orientation=c(90,-180,0))
plot(xymapproj$x, xymapproj$y, type='l', asp=1)
mtext("mapproj", side=3, font=2, col='purple', line=-1.5)
showbad(xymapproj$x, xymapproj$y)

xyproj4 <- project(cbind(lon, lat),
                   list(proj="moll", lon_0=-180))
plot(xyproj4[,1], xyproj4[,2], type='l', asp=1)
mtext("proj4", side=3, font=2, col='purple', line=-1.5)
showbad(xyproj4[,1], xyproj4[,2])
if (!interactive()) dev.off()
