library(rgdal)
lon0 <- 0                              # the below also fails for -180
for (epsilon in seq(10, -10, length.out=20)) {
    message("epsilon: ", epsilon)
    #xy <- rgdal::project(cbind(-180+epsilon,-90+epsilon), "+proj=wintri")
    xy <- rgdal::project(cbind(lon0+epsilon,-90+epsilon), "+proj=wintri")
    print(xy)
    lonlat <- rgdal::project(xy, "+proj=wintri", inv=TRUE)
    print(lonlat)
}

