## harder test ... fails
theta <- seq(0, 2*pi, length.out=32)
lon0 <- 180
Rx <- 5
Ry <- 2
lon <- 179.3 - Rx + Rx*cos(theta)+Rx*sin(theta/2)*1.5
lat <- 0 + Ry * sin(theta)
par(mfrow=c(1,2), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
plot(lon, lat, asp=1, type='o')
text(lon, lat, seq_along(lon), pos=2)
abline(v=lon0, col='blue')
abline(v=lon0+0.25*c(-1,1), col='blue', lty='dotted')

system("R CMD SHLIB polygon.c") 
dyn.load("polygon.so")
nlon <- length(lon)
mod <- .C("polygon_subdivide_vertically",
          n=as.integer(nlon), x=as.double(lon), y=as.double(lat), x0=as.double(lon0),
          nomax=as.integer(4*nlon), no=integer(1), xo=double(4*nlon), yo=double(4*nlon), NAOK=TRUE)
mod$xo <- mod$xo[1:mod$no];mod$yo <- mod$yo[1:mod$no]
points(mod$xo, mod$yo, col='red', pch=21);lines(lon, lat)
plot(mod$xo, mod$yo, xlim=range(lon), ylim=range(lat), asp=1)
abline(v=lon0, col='blue')
abline(v=lon0+0.25*c(-1,1), col='blue', lty='dotted')
polygon(mod$xo, mod$yo, col=rgb(0.8, 0.8, 0.8))#, alpha=0.1))
##text(mod$xo, mod$yo, seq_along(mod$xo)-1, pos=2)
points(lon, lat, bg='red', col='blue', pch=21)
