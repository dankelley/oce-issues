theta <- seq(0, 2*pi, length.out=8)
R <- 4
lon0 <- 180
lon <- lat <- NULL
lon <- c(lon, 170 + R * cos(-theta))
lat <- c(lat, R * sin(-theta))
lon <- c(lon, NA)
lat <- c(lat, NA)

lon <- c(lon, 180 + R * cos(-theta))
lat <- c(lat, R * sin(-theta))
lon <- c(lon, rep(NA,2))
lat <- c(lat, rep(NA,2))

lon <- c(lon, 190 + R * cos(-theta))
lat <- c(lat, R * sin(-theta))
nlon <- length(lon)

cat("nlon=", nlon, "\n")
par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
plot(lon, lat, pch=20, type='o', cex=2/3)
text(lon, lat, seq_along(lon)+1, pos=2)
abline(v=lon0)
system("R CMD SHLIB polygon.c") 
dyn.load("polygon.so")
nx <- length(lon)
mod <- .C("polygon_subdivide_vertically",
          n=as.integer(nlon), x=as.double(lon), y=as.double(lat),
          x0=as.double(lon0),
          no=integer(1), xo=double(2*nx), lato=double(2*nx),
          NAOK=TRUE)
#data.frame(lon=lon, lat=lat)
lines(lon, lat)
#points(mod$lono[1:mod$no], mod$lato[1:mod$no], col='red', cex=2)
