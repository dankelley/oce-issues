## Isolate Australia for testing.

if (!interactive()) pdf("388H.pdf", width=7, height=2, pointsize=8)
library(oce)
load("coastlineAustralia.rda") # ca
par(mar=c(3, 3, 1.5, 1), mgp=c(2, 0.7, 0), mfrow=c(1,3))
plot(ca[['longitude']], ca[['latitude']], type='l', asp=1)
points(ca[['longitude']][1], ca[['latitude']][1], cex=4)
mtext("clockwise from large circle", adj=0)

cut <- 120
abline(v=cut)
lon <- ca[['longitude']]
lat <- ca[['latitude']]
r <- lon > cut
rle <- rle(r)
ends <- cumsum(rle$lengths)
starts <- head(c(1, ends+1), -1)
for (s in seq_along(ends)) {
    points(lon[starts[s]:ends[s]], lat[starts[s]:ends[s]], pch=20, col=s)
}

## Find first rightward crossing 
start <- which(diff(r)>0)[1] + 1
n <- length(lon)
nlon <- lon[c(seq.int(start, n), seq.int(1, start-1))]
nlat <- lat[c(seq.int(start, n), seq.int(1, start-1))]
plot(nlon, nlat, type='l', asp=1)
abline(v=cut)
r <- nlon > cut
rle <- rle(r)
ends <- cumsum(rle$lengths)
starts <- head(c(1, ends+1), -1)
for (s in seq_along(ends)) {
    points(nlon[starts[s]:ends[s]], nlat[starts[s]:ends[s]], pch=20, col=s)
}
points(nlon[1], nlat[1], cex=4)
mtext("clockwise from large circle", adj=0)

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

