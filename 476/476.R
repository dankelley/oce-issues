library(oce)
try({
    source("~/src/oce/R/map.R")
})
halifax <- list(latitude=44.6478, longitude=-63.5714)
map <- mapproject(halifax$longitude, halifax$latitude, proj="mercator")
lonlat <- map2lonlat(map$x, map$y)
errLon <- abs(lonlat$longitude - halifax$longitude)
errLat <- abs(lonlat$latitude - halifax$latitude)
message("errLon: ", errLon)
message("errLan: ", errLat)
allow <- 10 / 111e3                    # 10 m
stopifnot(errLon < allow)
stopifnot(errLat < allow)

