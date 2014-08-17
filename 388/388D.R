if (!interactive()) pdf("388D.pdf", height=5, pointsize=9)
factor <- 2.7
newzealand <- FALSE
ncut <- 30                             # number of expected cut lines
proj <- "+proj=moll +lon_0=-60"
                                        #proj <- "+proj=moll"
par(mfrow=c(2,2), mgp=c(2, 0.7, 0), mar=c(3, 3, 2, 1))
library(oce)
library(proj4)
## Establish statistics based on large dataset
data(coastlineWorld)
longitude <- coastlineWorld[["longitude"]]
latitude <- coastlineWorld[["latitude"]]
n <- length(longitude)


analyze <- function(proj, factor=3)
{
    xy <- project(cbind(longitude, latitude), proj=proj)
    plot(xy, type='l', asp=1)# , xlim=c(-1.3e7, -0.8e7), ylim=c(-6e6,-4e6))
    mtext(paste('proj="', proj, '", factor:', factor, sep=''), adj=0)
    D <- geodDist(longitude, latitude, alongPath=TRUE)[-1] # drop first (zero)
    d <- sqrt(diff(xy[,1])^2 + diff(xy[,2])^2)
                                        #d <- sqrt(diff(xy[,1])^2)
    wildness <- d/D / median(d/D, na.rm=TRUE)

    W <- log10(d / D + 1e-5)
    Wcutoff <- mean(W,na.rm=TRUE) + factor * sd(W, na.rm=TRUE)
    nonNormal <- W > Wcutoff

    if (0) {
        terrible<-50
        terrible <- quantile(wildness, .995, na.rm=TRUE) # 0.995 breaks up New Zeland
        terrible <- quantile(wildness, 1-ncut/n, na.rm=TRUE)
        bad <- wildness > terrible
    } else {
        bad <- nonNormal
    }
    bad <- c(bad, FALSE) # kludge for length
    points(xy[bad,1], xy[bad,2], col='red')

    if (0) {
        hist(log10(1e-3+wildness), breaks=50)
        abline(v=log10(terrible), lty='dotted', col='red')
    } else {
        hist(log10(d/D+1e-5), breaks=seq(-5, 6, 0.1),
             xlim=c(-5, 6),main=paste("nonNormal: ", sum(nonNormal,na.rm=TRUE), "; proj:", proj))
        abline(v=Wcutoff, lty='dotted', col='red')
    }
    if (newzealand) {
        plot(xy[,1], xy[,2], type='l', asp=1, xlim=c(-1.15e7, -1.0e7), ylim=c(-4.9e6,-4.7e6))
        odd <- 7321 # index of a 'bad' point in New Zealand
        odd <- odd
        points(xy[odd,1], xy[odd,2], col='blue')
        points(xy[bad,1], xy[bad,2], col='red')
        legend("topright", pch=1, col=c('red','blue'), legend=c("bad", "odd"), bg='white')
        mtext("New Zealand")
        mtext(paste(" odd=", odd), side=1, line=-1, adj=0, col='blue')
        N <- 34
        ni <- odd - seq.int(0, 34) # North Island
        n <- length(longitude)
        DF<-data.frame(index=(1:n)[ni], lon=longitude[ni], lat=latitude[ni], x=xy[,1][ni], y=xy[,2][ni], bad=bad[ni], d=d[ni], D=D[ni], wildness=wildness[ni])
                                        #plot(DF$lon, DF$lat, type='l')
                                        #plot(DF$lon, -DF$lat, type='l')
        plot(longitude[ni], latitude[ni], type='l', asp=1/cos(pi/180*mean(latitude[ni], na.rm=TRUE)))
        points(longitude[bad], latitude[bad], col='red')
        mtext(paste(" index", min(ni), "to", max(ni)), side=1, line=-1, adj=0, col='blue')
        mtext("New Zealand (points go clockwise)")
        badNZ <- 7287
                                        #points(xy[badNZ,1], xy[badNZ,2], col='green', cex=2)
        mtext(paste(" index", min(ni), "to", max(ni)), side=1, line=-1, adj=0, col='blue')
        mtext(paste(" bad index", badNZ), side=1, line=-2, adj=0, col='blue')
                                        #DF
    }
}

analyze("+proj=moll", factor=factor)
analyze("+proj=moll +lon_0=-60", factor=factor)

## ## Fake island
## R <- 5
## n <- 11
## theta <- seq(0, 2*pi, length.out=n)
## 
## lon <- 180 + R * cos(theta)
## lat <-  40 + R * sin(theta)
## ## Coastline files do not repeat start point at end
## lon <- lon[-1]
## lat <- lat[-1]
## n <- length(lon)
## 
## index <- seq.int(1L, n)
## xy <- project(cbind(lon, lat), proj=proj)
## x <- xy[,1]
## y <- xy[,2]
## plot(x, y, asp=1, type='o')
## ## geodetic distance
## D <- geodDist(lon, lat, alongPath=TRUE)[-1] # drop first (which is zero)
## D <- c(D, geodDist(lon[1], lat[1], lon[n], lat[n]))
## D
## ## xy distance
## d <- sqrt(diff(x)^2 + diff(y)^2)
## d <- c(d, sqrt((x[1]-x[n])^2+(y[1]-y[n])^2))
## dD <- d / D
## wildness <- dD / mean(dD, na.rm=TRUE)
## ##plot(index, log10(wild+0.0001)) # add something to handle repeated points
## plot(index, wildness)
## grid()
## 
## cuts <- sum(wildness > 1)
## ## Next will be expensive so should do in C, for sure
## x2 <- NULL
## y2 <- NULL
## j <- 1
## for (i in 1:n) { # FIXME handle end
##     if (wildness[i] < 1) {
##         ## ok, just copy
##         x2 <- c(x2, x[i])
##         y2 <- c(y2, y[i])
##     } else {
##         x2 <- c(x2, NA, x[i])
##         y2 <- c(y2, NA, y[i])
##     }
## }
## plot(x2, y2, asp=1, type='o')
if (!interactive()) dev.off()

