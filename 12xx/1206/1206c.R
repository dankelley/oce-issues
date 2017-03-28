library(oce)
library(marmap)
data(section)
lon <- section[["longitude", "byStation"]]
lat <- section[["latitude", "byStation"]]
lon1 <- min(lon) - 0.5
lon2 <- max(lon) + 0.5
lat1 <- min(lat) - 0.5
lat2 <- max(lat) + 0.5
b <- getNOAA.bathy(lon1, lon2, lat1, lat2)
plot(section, which="salinity", xtype="longitude")
dist <- geodDist(section)
bottom <- get.depth(b, x=lon, y=lat, locator=FALSE)
lines(lon, -bottom$depth, col='red')


