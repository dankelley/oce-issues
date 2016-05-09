library(rgdal)
lon0 <- -180                           # try both 0 and -180
for (epsilon in seq(10, -1, -1)) {
    message("epsilon: ", epsilon)
    #xy <- rgdal::project(cbind(-180+epsilon,-90+epsilon), "+proj=wintri")
    xy <- rgdal::project(cbind(lon0+epsilon,-90+epsilon), "+proj=wintri")
    print(xy)
    lonlat <- rgdal::project(xy, "+proj=wintri", inv=TRUE)
    print(lonlat)
}

