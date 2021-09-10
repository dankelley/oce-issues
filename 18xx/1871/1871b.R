# Check: in the data frame shown at the end, do LON and LAT equal lon and lat?
library(sf)
p <- "+proj=ortho +lon_0=-63 +lat_0=44"
p0 <- "+proj=longlat +datum=WGS84 +no_defs"

lon <- seq(-180, 180, 15)
lat <- rep(85, 25)
plot(lon, lat)

xy <- sf::sf_project(p0, p, cbind(lon, lat))
S <- 1e3
if (!interactive()) png("1871b.png")
plot(xy[,1]/S, xy[,2]/S, asp=1, xlab="easting [km]", ylab="northing [km]")
grid()
LONLAT <- sf::sf_project(p, p0, xy, keep=TRUE)
df <- data.frame(lon=lon, lat=lat, x=xy[,1], y=xy[,2], LON=LONLAT[,1], LAT=LONLAT[,2])
print(df)
ok <- is.finite(df$LON)
points(xy[ok,1]/S, xy[ok,2]/S, pch=20)
mtext("filled symbols indicate invertible points")
if (!interactive()) dev.off()


