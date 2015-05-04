theta <- seq(0, 2*pi, length.out=8)
R <- 4
lon0 <- 180
lon <- lat <- NULL
#lon <- c(lon, 170 + R * cos(-theta))
#lat <- c(lat, R * sin(-theta))
#lon <- c(lon, NA)
#lat <- c(lat, NA)

lon <- c(lon, 180 + R * cos(-theta))
lat <- c(lat, R * sin(-theta))
#lon <- c(lon, rep(NA,2))
#lat <- c(lat, rep(NA,2))

#lon <- c(lon, 190 + R * cos(-theta))
#lat <- c(lat, R * sin(-theta))
nlon <- length(lon)

cat("nlon=", nlon, "\n")
par(mfrow=c(1,2), mar=c(3, 3, 2, 1), mgp=c(2, 0.7, 0))
plot(lon, lat, pch=20, type='o', cex=2/3)
text(lon, lat, seq_along(lon)-1, pos=2)
abline(v=lon0, col='blue')
system("R CMD SHLIB polygon.c") 
dyn.load("polygon.so")
nx <- length(lon)
mod <- .C("polygon_subdivide_vertically",
          n=as.integer(nlon), x=as.double(lon), y=as.double(lat), x0=as.double(lon0),
          nomax=as.integer(4*nx), no=integer(1), xo=double(4*nx), yo=double(4*nx), NAOK=TRUE)
mod$xo <- mod$xo[1:mod$no];mod$yo <- mod$yo[1:mod$no]
points(mod$xo, mod$yo, col='red', pch=21);lines(lon, lat)
plot(mod$xo, mod$yo, xlim=range(lon), ylim=range(lat))
abline(v=lon0, col='blue')
polygon(mod$xo, mod$yo, col=rgb(0.2, 0.2, 0.2, alpha=0.1));text(mod$xo, mod$yo, seq_along(mod$xo)-1, pos=2)
points(lon, lat, bg='red', col='blue', pch=21)
print(data.frame(lon=mod$xo, lat=round(mod$yo, 5)))
mtext("Bad point near cut (top or bottom)", side=3, line=0, col='red', font=2)
