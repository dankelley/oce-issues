## Test methods for chopping at a given longitude (x0)
library(oce)
data(coastlineWorld)

system("R CMD SHLIB polygon3.c") 
dyn.load("polygon3.so")

local_coastlineCut <- function(coastline, lon0=0)
{
    cleanAngle <- function(a)
        ifelse(a<(-180), a+360, ifelse(a>180, a-360, a))
    loncut <- cleanAngle(lon0+180)
    lon <- coastline[["longitude"]]
    lat <- coastline[["latitude"]]
    nlon <- length(lon)
    e <- 4                             # a bit over 2 should be more than enough for any coastline
    cut <- .C("polygon_subdivide_vertically3",
              n=as.integer(nlon), x=as.double(lon), y=as.double(lat), x0=as.double(loncut),
              nomax=as.integer(e*nlon), no=integer(1), xo=double(e*nlon), yo=double(e*nlon),
              NAOK=TRUE)
    cut$xo <- cut$xo[1:cut$no]
    cut$yo <- cut$yo[1:cut$no]
    as.coastline(longitude=cut$xo, latitude=cut$yo)
}


if (!interactive()) pdf("08.pdf", width=7, height=7, pointsize=8)
par(mar=c(2, 2, 1, 1), mgp=c(2, 0.7, 0))
par(mfrow=c(2,1))
xlim <- ylim <- NULL # yields identical map scales on successive pages
for (lon0 in seq(-180, 180, 10)) {
##for (lon0 in 10) {
    proj <- "wintri"
    proj <- "robin"
    mod <- coastlineCut(coastlineWorld, lon0=lon0) #ut=cleanAngle(lon0+180))
    lon <- mod[["longitude"]]
    lat <- mod[["latitude"]]
    plot(lon, lat, xlim=c(-180,180), ylim=c(-90,90), type='l')
    lines(c(-180, 180, 180, -180, -180), c(-90, -90, 90, 90, -90), col='gray')
    polygon(lon, lat, col='gray')
    proj <- sprintf("+proj=%s +lon_0=%.0f", proj, lon0)
    if (is.null(xlim)) {
        mapPlot(mod, fill='gray', proj=proj)
        xlim <- par('usr')[1:2]
        ylim <- par('usr')[3:4]
    } else {
        mapPlot(mod, fill='gray', proj=proj, xlim=xlim, ylim=ylim, xaxs="i", yaxs="i")
    }
    mtext(proj, side=3, line=0, adj=1)
}
if (!interactive()) dev.off()
