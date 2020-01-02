## skip all code, since this problem has been reported and addressed.
if (FALSE) {
    library(oce)
    data(coastlineWorld)

    if (FALSE) {
        ## Error in CPL <- proj <- direct(as.character(c(from[1], to[1])), as.matrix(pts)) :
        ##   tolerance condition error
        mapPlot(coastlineWorld,
                longitudelim=c(-130,-55), latitudelim=c(35, 60),
                projection="+proj=lcc +lat_0=30 +lat_1=60 +lon_0=-100", col='gray')
    }

    lon <- coastlineWorld[["longitude"]]
    lat <- coastlineWorld[["latitude"]]
    na <- is.na(lon)
    lon[na] <- 0
    lat[na] <- 0
    lonlat <- cbind(lon, lat)
    print(dim(lonlat))
    southpole <- abs(lat - (-90)) < 1e-5
    print(which(southpole))
    options(digits=20)
    lat[which.min(lat)]
    lonlat[southpole, 2] <- -89.9999
    ## OK from 1:826, but 827 is bad:
    ##
    ## lonlat[825:827,]
    ##           lon       lat
    ## [1,] 178.2772 -84.47252
    ## [2,] 180.0000 -84.71338
    ## [3,] 180.0000 -90.00000
    look <- 825:827
    xy <- sf::sf_project("+proj=longlat", "+proj=lcc +lat_0=30 +lat_1=60 +lon_0=-100", lonlat[825:827,])
    xy <- sf::sf_project("+proj=longlat", "+proj=lcc +lat_0=30 +lat_1=60", cbind(0, -90))


}
