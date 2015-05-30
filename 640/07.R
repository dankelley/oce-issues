## Test methods for chopping at a given longitude (x0)
library(oce)
data(coastlineWorld)
lon <- coastlineWorld[["longitude"]]
lat <- coastlineWorld[["latitude"]]
nlon <- length(lon)
system("R CMD SHLIB polygon3.c") 
dyn.load("polygon3.so")

if (!interactive()) pdf("07.pdf", width=7, height=4, pointsize=8)
par(mfcol=c(1,2), mar=c(2, 2, 1, 1), mgp=c(2, 0.7, 0))

plot(lon, lat, xlim=c(-180,180), ylim=c(-90,90), type='l')
polygon(lon, lat, col='pink')

e <- 4
lon0 <- 100
mod <- .C("polygon_subdivide_vertically3",
          n=as.integer(nlon), x=as.double(lon), y=as.double(lat), x0=as.double(lon0),
          nomax=as.integer(e*nlon), no=integer(1), xo=double(e*nlon), yo=double(e*nlon), NAOK=TRUE)
plot(mod$xo, mod$yo, xlim=c(-180,180), ylim=c(-90,90), type='l')
polygon(mod$xo, mod$yo, col='pink')
points(-0.6068137, -0.01742093, col='blue', cex=3) # an odd spot
mtext("See the blue circled odd spot", side=3, line=0, col='blue', adj=0)

if (!interactive()) dev.off()
