library(oce)
try({
    source("~/src/oce/R/map.R")
})
halifax <- list(latitude=44.6478, longitude=-63.5714)
for (proj in c("mercator", "stereographic")) {
    map <- mapproject(halifax$longitude, halifax$latitude, proj=proj)
    lonlat <- map2lonlat(map$x, map$y)
    errLon <- abs(lonlat$longitude - halifax$longitude)
    errLat <- abs(lonlat$latitude - halifax$latitude)
    message("projection: ", proj,
            ", errLon: ", format(errLon, digits=2),
            ", errLan: ", format(errLat, digits=2))
    allow <- 10 / 111e3                    # 10 m
    stopifnot(errLon < allow)
    stopifnot(errLat < allow)
}
