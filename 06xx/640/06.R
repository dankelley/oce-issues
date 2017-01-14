## harder test ... fails
theta <- seq(0, 2*pi, length.out=32)
lon0 <- 180
Rx <- 5
Ry <- 2
lon <- 179.3 - Rx + Rx*cos(theta)+Rx*sin(theta/2)*1.5
lat <- 0 + Ry * sin(theta)
load("longitude_latitude.rda") # spline after manual clicking
lon <- longitude
lat <- latitude

par(mfrow=c(1,2), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
plot(lon, lat, asp=1, type='o', pch=21, cex=1/2)
polygon(lon, lat, col='pink')
abline(v=lon0, col='blue')

system("R CMD SHLIB polygon.c") 
dyn.load("polygon.so")
nlon <- length(lon)
e <- 4
mod <- .C("polygon_subdivide_vertically2",
          n=as.integer(nlon), x=as.double(lon), y=as.double(lat), x0=as.double(lon0),
          nomax=as.integer(e*nlon), no=integer(1), xo=double(e*nlon), yo=double(e*nlon), NAOK=TRUE)
mod$xo <- mod$xo[1:mod$no];mod$yo <- mod$yo[1:mod$no]

plot(lon, lat, xlim=range(lon), ylim=range(lat), asp=1, type='n')
##plot(mod$xo, mod$yo, xlim=range(lon), ylim=range(lat), asp=1, type='l')
polygon(mod$xo, mod$yo, col='pink')
abline(v=lon0, col='blue')
#polygon(mod$xo, mod$yo, col=rgb(0.8, 0.8, 0.8))#, alpha=0.1))
##text(mod$xo, mod$yo, seq_along(mod$xo)-1, pos=2)
#points(lon, lat, bg='red', col='blue', pch=21)
#plot(lon, lat,type='l')
