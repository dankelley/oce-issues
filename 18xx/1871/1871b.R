# Check: in the data frame shown at the end, do LON and LAT equal lon and lat?
library(sf)
p <- "+proj=ortho +lon_0=-63 +lat_0=44"
p0 <- "+proj=longlat +datum=WGS84 +no_defs"

lon <- seq(-180, 180, 15)
lat <- rep(85, 25)

xy <- sf::sf_project(p0, p, cbind(lon, lat))
LONLAT <- sf::sf_project(p, p0, xy, keep=TRUE)
df <- data.frame(lon=lon, lat=lat, x=xy[,1], y=xy[,2], LON=LONLAT[,1], LAT=LONLAT[,2])
print(df)

