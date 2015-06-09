## what's wrong with Antarctica?
TEST <- !FALSE
## Test methods for chopping at a given longitude (x0)
library(oce)
##source("~/src/oce/R/map.R")
data(coastlineWorld)
lon <- coastlineWorld[["longitude"]]
lat <- coastlineWorld[["latitude"]]
##lat[lat==-90] <- -89.99
nlon <- length(lon)
system("R CMD SHLIB polygon4.c") 
dyn.load("polygon4.so")

cleanAngle <- function(a)
    ifelse(a<(-180), a+360, ifelse(a>180, a-360, a))

if (!interactive()) pdf("07_5.pdf", width=7, height=7, pointsize=8)
##layout(matrix(c(1,2,3,3), 2, 2, byrow = TRUE), respect = TRUE)
par(mar=c(2, 2, 1, 1), mgp=c(2, 0.7, 0))
par(mfrow=c(2,2))
xlim <- ylim <- NULL # yields identical map scales on successive pages
##for (lon_0 in seq(-180, 180, 10)[13]) {
for (lon_0 in -60) {
    e <- 4
    proj <- "robin"
    proj <- "wintri"
    mod <- .C("polygon_subdivide_vertically4",
              n=as.integer(nlon), x=as.double(lon), y=as.double(lat), x0=as.double(lon_0),
              nomax=as.integer(e*nlon), no=integer(1),
              xo=double(e*nlon), yo=double(e*nlon), insideo=integer(e*nlon),
              NAOK=TRUE)
    modORIG <- mod
    mod$xo <- mod$xo[1:mod$no]
    mod$yo <- mod$yo[1:mod$no]
    mod$insideo <- 1 == mod$insideo[1:mod$no]
    if (TEST) {
        mod$xo <- mod$xo[mod$insideo]
        mod$yo <- mod$yo[mod$insideo]
    }
    ##plot(mod$xo, mod$yo, xlim=c(-180,180), ylim=c(-90,90), type='l')

    indices <- seq_along(lon)
    LOOK <- 998:999
    LOOK2 <- 333:334
    if (TRUE) {
        par(mar=c(1.5,1.5,0.5,0.5), mgp=c(2,0.5,0))
        ##par(mfrow=c(2,2), mar=c(1.5,1.5,0.5,0.5), mgp=c(2,0.5,0))
        layout(matrix(1:4,byrow=TRUE, ncol=2), widths=rep(1,2), heights=c(0.2, 0.8))
        plot(lon, lat, xlim=c(-180,180), ylim=c(-90,-63), type='l')
        polygon(lon, lat, col='lightgray')
        points(lon[LOOK], lat[LOOK], pch=20, col=2:3)
        points(lon[LOOK2], lat[LOOK2], pch=20, col=4:5)
        text(lon[LOOK2], lat[LOOK2], pos=c(1,4), labels=indices[LOOK2], cex=2/3)
        inside <- !is.na(lon)&(-68)<lon&lon<(-50)&(-65)<lat&lat<(-60)
        text(lon[LOOK], lat[LOOK], pos=c(1,4), labels=indices[LOOK], cex=2/3)
        abline(v=lon_0, col='red', lwd=1/2, lty='dotted')
        plot(mod$xo, mod$yo, xlim=c(-180,180), ylim=c(-90,-63), type='l')
        polygon(mod$xo, mod$yo, col='lightgray')
        abline(v=lon_0, col='red', lwd=1/2, lty='dotted')

        plot(lon, lat, xlim=c(-62,-57), ylim=c(-90,-63), type='o', pch=20, cex=2/3)
        points(lon[LOOK], lat[LOOK], pch=20, col=2:3)
        text(lon[LOOK], lat[LOOK], pos=c(4,1), labels=indices[LOOK], cex=2/3)
        points(lon[LOOK2], lat[LOOK2], pch=20, col=2:3)
        text(lon[LOOK2], lat[LOOK2], pos=c(4,1), labels=indices[LOOK2], cex=2/3)
        inside <- !is.na(lon)&(-68)<lon&lon<(-50)&(-65)<lat&lat<(-60)
        abline(v=lon_0, col='red', lwd=1/2, lty='dotted')
        ## xy <- locator(1)
        # #which.min(abs(lon-xy$x)+abs(lat-xy$y))
        points(lon[445], lat[445], pch=20, col=6)
        text(lon[445], lat[445], 445, cex=2/3, pos=1)
        message("lon[442:446]:", paste(lon[442:446], collapse=" "))
        message("lat[442:446]:", paste(lat[442:446], collapse=" "))

        plot(mod$xo, mod$yo, xlim=c(-62,-57), ylim=c(-90,-63), type='o', pch=20, cex=2/3)
        polygon(mod$xo, mod$yo, col='lightgray')
        points(mod$xo, mod$yo, pch=20, col='black')
        points(mod$xo[mod$insideo], mod$yo[mod$insideo],pch=20, col='red', cex=0.3)
        abline(v=lon_0, col='red', lwd=1/2, lty='dotted')

        message("Q: is there a break at the tip (look at numbers)")
        stop()
    }

    #lines(c(-180, 180, 180, -180, -180), c(-90, -90, 90, 90, -90), col='gray')
    # polygon(mod$xo, mod$yo, col='gray')
    ## proj <- sprintf("+proj=%s +lon_0=%.0f", proj, cleanAngle(lon_0-180))
    ## if (is.null(xlim)) {
    ##     mapPlot(as.coastline(mod$xo, mod$yo), fill='gray', proj=proj)
    ##     xlim <- par('usr')[1:2]
    ##     ylim <- par('usr')[3:4]
    ##     ##mapPoints(mod$xo[!mod$insideo], mod$yo[!mod$insideo], col='red', pch=20, cex=1/2)
    ## } else {
    ##     mapPlot(as.coastline(mod$xo, mod$yo), fill='gray', proj=proj, xlim=xlim, ylim=ylim,
    ##             xaxs="i", yaxs="i")
    ##     ##mapPoints(mod$xo[!mod$insideo], mod$yo[!mod$insideo], col='red', pch=20, cex=1/2)
    ## }
    ## mtext(proj, side=3, line=0, adj=1)
    mtext("bad Antarctic pt if lon_0=120", side=3, line=0.25, adj=0, col='magenta', font=2)
}
if (!interactive()) dev.off()
