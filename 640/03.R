theta <- seq(0, 2*pi, length.out=32)
R <- 5
lat0 <- 0
lon0 <- 180
lon <- lon0 + R * cos(-theta)
lat <- lat0 + R * sin(-theta)
nlon <- length(lon)
plot(lon, lat, type='o')
#text(lon, lat, seq.int(0, nlon-1), pos=1)
abline(v=180)
system("R CMD SHLIB lonchop1.c") 
dyn.load("lonchop1.so")
mod <- .C("lonchop", as.integer(nlon), as.double(lon), as.double(lat),
          as.double(lon0), double(2*nlon), double(2*nlon))
lines(lon, lat)
points(mod[[5]], mod[[6]], col='red', cex=2)
