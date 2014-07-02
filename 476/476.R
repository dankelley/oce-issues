library(oce)
try({
    source("~/src/oce/R/map.R")
})
halifax <- list(latitude=44.6478, longitude=-63.5714)
projections <- c("mercator", "stereographic")
err <- matrix(nrow=length(projections), ncol=2)
for (i in seq_along(projections)) {
    map <- mapproject(halifax$longitude, halifax$latitude, proj=projections[i])
    lonlat <- map2lonlat(map$x, map$y)
    err[i, 1] <- abs(lonlat$longitude - halifax$longitude)
    err[i, 2] <- abs(lonlat$latitude - halifax$latitude)
}
rownames(err) <- projections
colnames(err) <- c("Lon Err", "Lat Err")
print(err)
message("RMS error: ", format(sqrt(mean(err^2)), digits=2), " deg with default tolerance.")
