## Isolate Australia for testing.

if (!interactive()) pdf("388H.pdf", height=4)
library(oce)
load("coastlineAustralia.rda") # ca
par(mfrow=c(1,3))
plot(ca[['longitude']], ca[['latitude']], asp=1)
## points(ca[['longitude']][1:2], ca[['latitude']][1:2],
##        cex=2, col=c("red","blue"))
points(ca[['longitude']][1], ca[['latitude']][1], cex=4)
mtext(" clockwise from large circle", adj=0, line=-1.5)

cut <- 120
abline(v=cut)
lon <- ca[['longitude']]
lat <- ca[['latitude']]
r <- lon > cut
rle <- rle(r)
ends <- cumsum(rle$lengths)
starts <- head(c(1, ends+1), -1)
for (s in seq_along(ends)) {
    points(lon[starts[s]:ends[s]], lat[starts[s]:ends[s]], col=s)
}

## Find first rightward crossing 
start <- which(diff(r)>0)[1] + 1
n <- length(lon)
nlon <- lon[c(seq.int(start, n), seq.int(1, start-1))]
nlat <- lat[c(seq.int(start, n), seq.int(1, start-1))]
plot(nlon, nlat, type='l', asp=1)
abline(v=cut)
points(nlon[1], nlat[1], col='red')
points(nlon[2], nlat[2], col='blue')
r <- nlon > cut
rle <- rle(r)
ends <- cumsum(rle$lengths)
starts <- head(c(1, ends+1), -1)
for (s in seq_along(ends)) {
    points(nlon[starts[s]:ends[s]], nlat[starts[s]:ends[s]], col=s)
}
points(nlon[1], nlat[1], cex=4)
mtext(" clockwise from large circle", adj=0, line=-1.5)

## Try polygons
plot(nlon, nlat, type='l', asp=1)
for (s in seq_along(ends)) {
    LON <- nlon[starts[s]:ends[s]]
    LAT <- nlat[starts[s]:ends[s]]
    LON <- c(cut, LON, cut)
    LAT <- c(LAT[1], LAT, LAT[length(LAT)])
    polygon(LON, LAT, col=s)
}
abline(v=cut)

if (!interactive()) dev.off()

