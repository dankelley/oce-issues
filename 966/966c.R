library(proj4)
lon0 <- -180                           # try both 0 and -180
for (epsilon in seq(10, -1, -1)) {
    message("\nepsilon: ", epsilon)
    #xy <- rgdal::project(cbind(-180+epsilon,-90+epsilon), "+proj=wintri")
    xy <- proj4::project(cbind(lon0+epsilon,-90+epsilon), "+proj=wintri")
    print(xy)
    lonlat <- proj4::project(xy, "+proj=wintri", inv=TRUE)
    print(lonlat)
}

