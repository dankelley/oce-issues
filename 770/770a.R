library(oce)
data(section)
lon <- section[["longitude", "byStation"]]
lat<- section[["latitude", "byStation"]]
n <- 24
lon <- lon[1:n]
lat <- lat[1:n]
lonR <- lon[1]
latR <- lat[1]
xy <- geodXy(lon, lat, lonR, latR)

## spherical
mperdeg <- geodDist(0, 36, 0, 37) * 1e3 # mid-latitude estimate
LAT <- latR + xy$y / mperdeg
LON <- lonR + xy$x / mperdeg / cos(pi*LAT / 180)
data.frame(lon=lon, lat=lat, x=xy$x, y=xy$y, LON=LON, LAT=LAT, lonerr=lon-LON, laterr=lat-LAT)
