## Test methods for chopping at a given longitude (x0)
library(oce)
data(coastlineWorld)
lon <- coastlineWorld[["longitude"]]
lat <- coastlineWorld[["latitude"]]
nlon <- length(lon)
system("R CMD SHLIB polygon3.c") 
dyn.load("polygon3.so")

if (!interactive()) pdf("07.pdf", width=6, height=7, pointsize=8)
##layout(matrix(c(1,2,3,3), 2, 2, byrow = TRUE), respect = TRUE)
par(mar=c(2, 2, 1, 1), mgp=c(2, 0.7, 0))
par(mfrow=c(2,1))

cleanAngle <- function(a)
    ifelse(a<(-180), a+360, ifelse(a>180, a-360, a))
for (lon0 in seq(-180, 180, 10)) {
    ## plot(lon, lat, xlim=c(-180,180), ylim=c(-90,90), type='l')
    ## lines(c(-180, 180, 180, -180, -180), c(-90, -90, 90, 90, -90), col='gray')
    ## polygon(lon, lat, col='pink')

    e <- 4
    proj <- "robin"
    mod <- .C("polygon_subdivide_vertically3",
              n=as.integer(nlon), x=as.double(lon), y=as.double(lat), x0=as.double(lon0),
              nomax=as.integer(e*nlon), no=integer(1), xo=double(e*nlon), yo=double(e*nlon),
              NAOK=TRUE)
    mod$xo <- mod$xo[1:mod$no]
    mod$yo <- mod$yo[1:mod$no]
    plot(mod$xo, mod$yo, xlim=c(-180,180), ylim=c(-90,90), type='l')
    lines(c(-180, 180, 180, -180, -180), c(-90, -90, 90, 90, -90), col='gray')
    polygon(mod$xo, mod$yo, col='pink')
    proj <- sprintf("+proj=%s +lon_0=%.0f", proj, cleanAngle(lon0-180))
    mapPlot(as.coastline(mod$xo, mod$yo), fill='pink', proj=proj)
    mtext(proj, side=3, line=0, adj=1)
}
if (!interactive()) dev.off()
