library(rgdal)
#project(cbind(-16070000, -10007000), proj="+proj=wintri +lon_0=90")
#project(cbind(-16079195.6212053, -10007538.6856213), proj="+proj=wintri +lon_0=90")
#stop()

## Test methods for chopping at a given longitude (x0)
library(oce)
source("~/src/oce/R/map.R")
data(coastlineWorld)
lon <- coastlineWorld[["longitude"]]
lat <- coastlineWorld[["latitude"]]
nlon <- length(lon)
system("R CMD SHLIB polygon3.c") 
dyn.load("polygon3.so")

if (!interactive()) pdf("07.pdf", width=7, height=7, pointsize=8)
##layout(matrix(c(1,2,3,3), 2, 2, byrow = TRUE), respect = TRUE)
par(mar=c(2, 2, 1, 1), mgp=c(2, 0.7, 0))
par(mfrow=c(2,1))

cleanAngle <- function(a)
    ifelse(a<(-180), a+360, ifelse(a>180, a-360, a))
## FIXED: lon0 -60 had problem with an island
## BUG:   lon0 -90 hangs
##for (lon0 in -90) {
for (lon0 in seq(-180, 180, 10)) {
    ## plot(lon, lat, xlim=c(-180,180), ylim=c(-90,90), type='l')
    ## lines(c(-180, 180, 180, -180, -180), c(-90, -90, 90, 90, -90), col='gray')
    ## polygon(lon, lat, col='pink')

    e <- 4
    proj <- "robin"
    proj <- "wintri"
    mod <- .C("polygon_subdivide_vertically3",
              n=as.integer(nlon), x=as.double(lon), y=as.double(lat), x0=as.double(lon0),
              nomax=as.integer(e*nlon), no=integer(1), xo=double(e*nlon), yo=double(e*nlon),
              NAOK=TRUE)
    message("AFTER call with lon0=", lon0)
    mod$xo <- mod$xo[1:mod$no]
    mod$yo <- mod$yo[1:mod$no]
    plot(mod$xo, mod$yo, xlim=c(-180,180), ylim=c(-90,90), type='l')
    lines(c(-180, 180, 180, -180, -180), c(-90, -90, 90, 90, -90), col='gray')
    polygon(mod$xo, mod$yo, col='pink')
    proj <- sprintf("+proj=%s +lon_0=%.0f", proj, cleanAngle(lon0-180))
    #TEST <- rgdal::project(cbind(mod$xo, mod$yo), proj=proj)
    mapPlot(as.coastline(mod$xo, mod$yo), fill='pink', proj=proj, debug=3)
    mtext(proj, side=3, line=0, adj=1)
}
## message("LOOK INTO THESE--")
## message("following should cross but not listed: poly 101 lon[4186:4194]")
## message(paste(lon[4185:4195], collapse=" "), " (added the NA to check)")
## message("> lon[4180:4185]")
## message("[1]        NA -179.9174 -180.0000 -180.0000 -179.7933        NA")

if (!interactive()) dev.off()
