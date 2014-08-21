rm(list=ls())
debug <- FALSE
if (!interactive()) pdf("388F.pdf", height=4, pointsize=9)
par(mar=c(2, 2, 1.5, 1), mgp=c(2, 0.7, 0), mfrow=c(2,2))

library(plyr)
library(proj4)
library(oce)
data(coastlineWorld)

for (proj in c("+proj=moll","+proj=moll +lon_0=-60", "+proj=merc", "+proj=merc +lon_0=-60")) {
    mapPlot(coastlineWorld, proj=proj, col='darkgray')
    latitude <- seq(-90+.1, 90-.1, length.out=20)
    n <- length(latitude)
    longitudeL <- rep(0, n)
    longitudeR <- rep(0, n)
    for (i in 1:n) {
        if (debug && i<5)message("latitude: ", latitude[i])
        range <- 180
        ## iterating to try to save some time; 20 longitudes times 11 iterations
        ## is 110 calculations, for 0.02 deg resolution, as opposed to a bit
        ## over 1 deg resolution for brute force.  However, brute force
        ## is simpler and more robust, and projecting is fast, so I may drop this.
        for (iteration in 1:11) {
            lon <- longitudeR[i] + seq(-range, range, length.out=20)
            x <- laply(lon, function(lon) project(cbind(lon,latitude[i]), proj=proj)[1,1])
            imax <- which.max(abs(diff(x)))
            longitudeR[i] <- lon[imax]
            if (debug && i<5)message(" ", longitudeR[i], " +- ", diff(lon[1:2]))
            range <- range / 2
        }
        longitudeL[i] <- if (imax==n) lon[1] else lon[imax+1]
    }
    longitudeR <- ifelse(longitudeR < 0, longitudeR + 360, longitudeR)
    longitudeL <- ifelse(longitudeL < 0, longitudeL + 360, longitudeL)

    ## Trace earth outline on map
    xyR <- project(list(longitude=longitudeR, latitude=latitude), proj=proj)
    lines(xyR$x, xyR$y, col='red', lwd=1.4)
    xyL <- project(list(longitude=longitudeL, latitude=latitude), proj=proj)
    lines(xyL$x, xyL$y, col='blue', lwd=1.4)
    if (length(grep("merc", proj))) {
        mtext("IGNORE: odd grid (avoid issue braids)", font=2, col="red", adj=0)
        mtext("EXPECT: blue and red earth edges", font=2, col="purple", adj=0, line=1)
    } else {
        mtext("EXPECT: blue and red earth edges", font=2, col="purple", adj=0)
    }
}

message("sd(longitudeR)=", sd(longitudeR))
message("sd(longitudeL)=", sd(longitudeL))

message("TO DO: start working on path chopping, prob with Australia")

if (!interactive()) dev.off()
