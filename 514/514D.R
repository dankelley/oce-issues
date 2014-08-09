library(oce)
try({
    source('~/src/oce/R/map.R')
})

# Found this point from 514C, one of many
lon <- -175
lat <- 50
xy <- mapproject(lon, lat, projection="mollweide")
## invert
LonLat <- map2lonlat(xy$x, xy$y)
Lat <- LonLat$latitude
Lon <- LonLat$longitude

message("lon: ", lon, " -> ", Lon)
message("lat: ", lat, " -> ", Lat)
