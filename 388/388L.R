message("388L.R trying to see if sp::nowrapSpatialLines() can help")
library(sp)

par(mfrow=c(2,3))
# from manpage
Sl <- SpatialLines(list(Lines(list(Line(cbind(sin(seq(-4,4,0.4)), seq(1,21,1)))), "1")),
                   proj4string=CRS("+proj=longlat +ellps=WGS84"))
summary(Sl)
coordinates(Sl)
nwSL <- nowrapSpatialLines(Sl)
summary(nwSL)
coordinates(nwSL)

Slcoord <- coordinates(Sl)[[1]]
for (i in seq_along(Slcoord)) {
    xy <- Slcoord[[i]]
    plot(xy[,1], xy[,2], col=i, type='o', xlim=c(-1,1), ylim=c(0,25))
    mtext(paste("orig", i), side=3, line=0, col='red')
    abline(v=0, lty='dotted', col='pink')
}

nwSLcoord <- coordinates(nwSL)[[1]]
for (i in seq_along(nwSLcoord)) {
    xy <- nwSLcoord[[i]]
    plot(xy[,1], xy[,2], col=i, type='o', xlim=c(-1,1), ylim=c(0,25))
    mtext(paste("nw", i), side=3, line=0, col='blue')
    abline(v=0, lty='dotted', col='pink')
}

