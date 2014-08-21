rm(list=ls())
## Find world coastline islands

if (!interactive()) pdf("388J.pdf", width=7, height=3.5, pointsize=8)
library(oce)

plotIsland <- function(lon, lat, cut=120)
{
    r <- lon > cut
    ## Reorder to start at first rightward crossing 
    start <- which(diff(r)>0)[1] + 1
    if (is.na(start)) {
        polygon(lon, lat, col='lightgray', lwd=1/4)
    } else {
        n <- length(lon)
        nlon <- lon[c(seq.int(start, n), seq.int(1, start-1))]
        nlat <- lat[c(seq.int(start, n), seq.int(1, start-1))]
        r <- nlon > cut
        rle <- rle(r)
        ends <- cumsum(rle$lengths)
        starts <- head(c(1, ends+1), -1)
        for (s in seq_along(ends)) {
            LON <- nlon[starts[s]:ends[s]]
            LAT <- nlat[starts[s]:ends[s]]
            LON <- c(cut, LON, cut)
            LAT <- c(LAT[1], LAT, LAT[length(LAT)])
            polygon(LON, LAT, col=s, lwd=1/4)
        }
        ## if (interactive()) Sys.sleep(1)
    }
}
cut <- 120
data(coastlineWorld)
longitude <- coastlineWorld[['longitude']]
latitude <- coastlineWorld[['latitude']]
system("R CMD SHLIB find_islands.c")
dyn.load("find_islands.so")
islands <- .Call("find_islands", longitude, latitude, cut)
par(mar=c(2, 2, 2, 1), mgp=c(2, 0.7, 0))
plot(c(-180, 180), c(-90, 90), type='n', asp=1, xlab="", ylab="")
abline(v=cut, lwd=1/3, col='green', lty='dotted')
for (island in seq_along(islands$begin)) {
    span <- seq.int(islands$begin[island], islands$end[island])
    plotIsland(longitude[span], latitude[span], cut=cut)
}
mtext("EXPECT: colour shift at cut point 120E", font=2, col='purple', adj=0)
mtext("PLAN: improve connection to cut", font=2, col='purple', adj=0, line=1)
if (!interactive()) dev.off()

