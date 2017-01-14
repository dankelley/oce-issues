library(oce)
data(section)
lon <- section[["longitude", "byStation"]]
lat<- section[["latitude", "byStation"]]
xy <- geodXy(lon, lat)
LONLAT <- geodXyInverse(xy$x, xy$y)
err <- sqrt((lon-LONLAT$longitude)^2+(lat-LONLAT$latitude)^2)
data.frame(lon=lon, lat=lat, x=xy$x, y=xy$y, err=err)

