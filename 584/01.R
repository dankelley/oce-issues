# http://www.remotesensing.org/geotiff/proj_list/
library(oce)
##source("~/src/oce/R/map.R")
show <- function(proj, latitudelim, longitudelim)
{
    if ("http:" == substr(proj, 1, 5)) {
        proj <- substr(proj, 8, nchar(proj))
        plot(1:2, 1:2, type='n', xlab="", ylab="", axes=FALSE)
        box()
        text(1.0, 1.5, proj, cex=0.8, adj=0)
    } else {
        mapPlot(coastlineWorld, projection=proj, fill="lightgray",
                latitudelim=latitudelim, longitudelim=longitudelim)
        mtext(proj, line=0.25, cex=0.7)
    }
}

if (!interactive()) pdf("01.pdf")
par(mfrow=c(3,2), mar=c(1.5, 1.5, 2, 1))
data(coastlineWorld)

show("+proj=aea    +lat_1=40 +lat_2=50 +lon_0=-100", longitudelim=c(-140, -60), latitudelim=c(40, 50))
show("+proj=aeqd   +lat_1=40 +lat_2=50 +lon_0=-100", longitudelim=c(-140, -60), latitudelim=c(40, 50))
show("+proj=cass   +lat_1=40 +lat_2=50 +lon_0=-100", longitudelim=c(-140, -60), latitudelim=c(40, 50))
show("+proj=cea    +lat_1=40 +lat_2=50 +lon_0=-100", longitudelim=c(-140, -60), latitudelim=c(40, 50))
show("+proj=eck4   +lat_1=40 +lat_2=50 +lon_0=-100", longitudelim=c(-140, -60), latitudelim=c(40, 50))
show("+proj=eck6   +lat_1=40 +lat_2=50 +lon_0=-100", longitudelim=c(-140, -60), latitudelim=c(40, 50))
show("+proj=eqdc   +lat_1=40 +lat_2=50 +lon_0=-100", longitudelim=c(-140, -60), latitudelim=c(40, 50))
show("http://www.remotesensing.org/geotiff/proj_list/equirectangular.html")
show("+proj=tmerc  +lat_1=40 +lat_2=50 +lon_0=-100", longitudelim=c(-140, -60), latitudelim=c(40, 50))
show("+proj=gall   +lat_1=40 +lat_2=50 +lon_0=-100", longitudelim=c(-140, -60), latitudelim=c(40, 50))
show("+proj=geos   +h=42164000")
show("+proj=gnom")
## lonc or lon_0 ?
show("+proj=omerc  +lat_1=40 +lat_2=50 +lon_0=-100", longitudelim=c(-140, -60), latitudelim=c(40, 50))
show("+proj=krovak +lat_1=40 +lat_2=50 +lon_0=-100", longitudelim=c(-140, -60), latitudelim=c(40, 50))
show("http://www.remotesensing.org/geotiff/proj_list/laborde_oblique_mercator.html")
show("+proj=laea   +lat_1=40 +lat_2=50 +lon_0=-100", longitudelim=c(-140, -60), latitudelim=c(40, 50))
show("+proj=lcc    +lat_1=40 +lat_2=50 +lon_0=-100", longitudelim=c(-140, -60), latitudelim=c(40, 50))
show("+proj=merc   +lon_0=-100", longitudelim=c(-140, -60), latitudelim=c(40, 50))
show("+proj=merc   +lat_ts=45 +lon_0=-100", longitudelim=c(-140, -60), latitudelim=c(40, 50))
show("+proj=mill   +lat_ts=45 +lon_0=-100", longitudelim=c(-140, -60), latitudelim=c(40, 50))
show("+proj=moll   +lat_ts=45 +lon_0=-100", longitudelim=c(-140, -60), latitudelim=c(40, 50))
show("+proj=sterea +lat_ts=45 +lon_0=-100", longitudelim=c(-140, -60), latitudelim=c(40, 50))
show("+proj=ortho  +lat_ts=45 +lon_0=-100", longitudelim=c(-140, -60), latitudelim=c(40, 50))
show("+proj=stere  +lat_ts=45 +lon_0=-100", longitudelim=c(-140, -60), latitudelim=c(40, 50))
show("+proj=robin  +lat_ts=45 +lon_0=-100", longitudelim=c(-140, -60), latitudelim=c(40, 50))
show("http://www.remotesensing.org/geotiff/proj_list/rosenmund_oblique_mercator.html")
show("+proj=sinu   +lat_ts=45 +lon_0=-100", longitudelim=c(-140, -60), latitudelim=c(40, 50))
show("http://www.remotesensing.org/geotiff/proj_list/swiss_oblique_cylindrical.html")
show("http://www.remotesensing.org/geotiff/proj_list/transverse_mercator_modified_alaska.html")
show("http://www.remotesensing.org/geotiff/proj_list/transverse_mercator_south_oriented.html")
show("http://www.remotesensing.org/geotiff/proj_list/tunisia_mining_grid.html")
show("http://www.remotesensing.org/geotiff/proj_list/vandergrinten.html")

## Albers Equal-Area Conic
## Azimuthal Equidistant
## Cassini-Soldner
## Cylindrical Equal Area
## Eckert IV
## Eckert VI
## Equidistant Conic
## Equidistant Cylindrical
## Equirectangular
## Gauss-Kruger
## Gall Stereographic
## GEOS - Geostationary Satellite View
## Gnomonic
## Hotine Oblique Mercator
## Krovak
## Laborde Oblique Mercator
## laea=Lambert Azimuthal Equal Area
## lcc=Lambert Conic Conformal (1SP)
## ?Lambert Conic Conformal (2SP)
## ?Lambert Conic Conformal (2SP Belgium)
## ?Lambert Cylindrical Equal Area
## merc=Mercator (1SP)
## merc=Mercator (2SP)
## mill=Miller Cylindrical
## moll=Mollweide
## ?New Zealand Map Grid
## (alias for hotine...) Oblique Mercator
## * Oblique Stereographic
## * Orthographic
## * Polar Stereographic
## * Polyconic
## * Robinson
## * Rosenmund Oblique Mercator
## * Sinusoidal
## * Swiss Oblique Cylindrical
## * Swiss Oblique Mercator
## * Stereographic
## * Transverse Mercator
## * Transverse Mercator (Modified Alaska)
## * Transverse Mercator (South Oriented)
## * Tunisia Mining Grid
## * VanDerGrinten

## hm, some others are available.
show("+proj=natearth")

if (FALSE) {
    ## 2. below a random sampling
    mapPlot(coastlineWorld, projection="+proj=hammer", fill="lightgray")
    mtext("+proj=hammer")
}

message("FIXME: check all options; what I have now is from cut/paste")
message("why is 'hammer' not in the list?")

if (!interactive()) dev.off()

