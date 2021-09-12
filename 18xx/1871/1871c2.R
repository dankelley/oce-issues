# Check: in the data frame shown at the end, do LON and LAT equal lon and lat?
library(oce)
library(sf)
data(coastlineWorld)
p0 <- "+proj=longlat +datum=WGS84 +no_defs +f=0 +a=6370"
p <- "+proj=ortho +lon_0=-63 +lat_0=44 +f=0 +a=6370"

if (!interactive()) png("1871c2.png")
par(mar=c(0.5, 0.5, 1, 0.5))
mapPlot(coastlineWorld, projection="+proj=ortho +lon_0=-63 +lat_0=44", type="p", pch=20, cex=0.2, col="forestgreen")

lon <- seq(-180, 180, 15)
for (lat0 in seq(-85, 85, 5)) {
    lat <- rep(lat0, 25)
    t <- try(xy <- sf::sf_project(p0, p, cbind(lon, lat), keep=TRUE))
    if (!inherits(t, "try-error")) {
        S <- 1e3
        LONLAT <- sf::sf_project(p, p0, xy, keep=TRUE)
        df <- data.frame(lon=lon, lat=lat, x=xy[,1], y=xy[,2], LON=LONLAT[,1], LAT=LONLAT[,2])
        print(df)
        ok <- is.finite(df$LON)
        mapPoints(lon, lat, pch=20, col=ifelse(ok, "red", "black"), cex=1)
    }
}
legend("topright", col=c("red","black"), pch=20, legend=c("invertible", "non-invertible"))
if (!interactive()) dev.off()


