library(oce)

rms <- function(x) sqrt(mean(x^2)) # convenience function

data(section)
lon <- section[["longitude", "byStation"]]
lat<- section[["latitude", "byStation"]]
lon <- lon
lat <- lat
lonR <- lon[1]
latR <- lat[1]
## 1. ellipse
xy <- geodXy(lon, lat, lonR, latR)

## 2. sphere
mperdeg <- geodDist(0, mean(lat)-0.5, 0, mean(lat)+0.5) * 1e3 # mid-latitude estimate
X <- (lon - lonR) * mperdeg * cos(lat * pi / 180)
Y <- (lat - latR) * mperdeg
XY <- list(x=X, y=Y)

if (!interactive()) png("770a.png")
par(mfrow=c(2,1), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
plot(lon, lat, asp=1/cos(median(lat*pi/180)))
plot(xy$x/1e3, xy$y/1e3, asp=1)
mtext(sprintf("ellipse-sphere RMS deviation: x %.2f km, y %.2f km",
              rms(xy$x-XY$x)/1e3, rms(xy$y-XY$y)/1e3),
      side=3, line=0)
mtext(sprintf("ellipse-sphere RMS deviation / span: x %.2g, y %.2g",
              rms(xy$x-XY$x)/1e3/diff(range(xy$x)), rms(xy$y-XY$y)/1e3/diff(range(xy$y))),
      side=3, line=-1)
if (!interactive()) dev.off()
