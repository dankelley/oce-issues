library(oce)
data(coastlineWorld)
# draw a map to set up the projection
if (!interactive()) png("1871a.png")
mapPlot(coastlineWorld, projection="+proj=ortho +lon_0=-63 +lat_0=44", type="p", pch=20, cex=1/3)
lon <- seq(-180, 180, 15)
lat <- rep(85, 25)
xy <- lonlat2map(lon, lat)
LONLAT <- map2lonlat(xy)
df <- data.frame(lon=lon, lat=lat, x=xy$x, y=xy$y, LON=LONLAT$longitude, LAT=LONLAT$latitude)
print(df)
if (!interactive()) dev.off()

