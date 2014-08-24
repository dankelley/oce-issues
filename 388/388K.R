rm(list=ls())
## Find world coastline islands

if (!interactive()) pdf("388K.pdf", width=7, height=2.5, pointsize=8)
library(oce)
par(mfrow=c(1,2))
lon2 <- NULL
lat2 <- NULL

plotIsland <- function(lon, lat, cut=120, border=1, plot=FALSE)
{
    r <- lon > cut
    ## Reorder to start at first rightward crossing 
    start <- which(diff(r)>0)[1] + 1
    if (is.na(start)) {
        if (min(abs(lon - cut), na.rm=TRUE) > border) {
            if (plot) {
                polygon(lon, lat, col='lightgray', lwd=1/4)
            } else {
                lon2 <<- c(lon2, lon, NA)
                lat2 <<- c(lat2, lat, NA)
            }
        } else {
            message("skip island with lon in range ", min(lon, na.rm=TRUE), " to ", max(lon, na.rm=TRUE),
                   " and mean lat ", mean(lat, na.rm=TRUE)) 
        }
    } else {
        n <- length(lon)
        nlon <- lon[c(seq.int(start, n), seq.int(1, start-1))]
        nlat <- lat[c(seq.int(start, n), seq.int(1, start-1))]
        r <- nlon > cut
        rle <- rle(r)
        ends <- cumsum(rle$lengths)
        starts <- head(c(1, ends+1), -1)
        for (s in seq_along(ends)) {
            chop <- if ((s %% 2)) cut + border else cut - border
            LON <- nlon[starts[s]:ends[s]]
            LAT <- nlat[starts[s]:ends[s]]
            if (nlon[starts[s]] > cut)
                LON <- c(cut + border, ifelse(LON < cut + border, cut+border, LON), cut + border)
            else
                LON <- c(cut - border, ifelse(LON > cut - border, cut-border, LON), cut - border)
            LAT <- c(LAT[1], LAT, LAT[length(LAT)])
            if (plot) {
                polygon(LON, LAT, col=s, lwd=1/4)
            } else {
                lon2 <<- c(lon2, LON, NA)
                lat2 <<- c(lat2, LAT, NA)
            }
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
polygon(lon2, lat2, col='lightgray')
abline(v=cut, lwd=0.25, col='red')
mtext("EXPECT: gap at 120E", font=2, col='purple', adj=0)

mapPlot(coastlineWorld, proj="+proj=moll +lon_0=-61")
mapPolygon(lon2, lat2, col='pink')
mtext("EXPECT: no ugly horizontal lines", font=2, col='purple', adj=0)
if (!interactive()) dev.off()

