library(oce)
data(coastlineWorld)
lon <- coastlineWorld[["longitude"]][1:10]
lat <- coastlineWorld[["latitude"]][1:10]
lat[5] <- 91 # bad point in middle
library(rgdal)
proj <- "+proj=moll +ellps=sphere"

owarn <- options()$warn
options(warn=-1)

xy <- rgdal::project(cbind(lon,lat), proj)
xy
XY <- lonlat2map(lon, lat, projection=proj)
data.frame(XY)

ll <- rgdal::project(xy, proj, inv=TRUE)
ll


fixinf <- function(x) {
    x[!is.finite(x)] <- NA
    x
}
XY$x <- fixinf(XY$x)
XY$y <- fixinf(XY$y)
LL <- map2lonlat(XY$x, XY$y)
LL

cat("ERROR in lonlat2map:", sd(xy-cbind(XY$x, XY$y), na.rm=TRUE), "\n")
cat("ERROR in map2lonlat:", sd(ll-cbind(LL$longitude,LL$latitude),na.rm=TRUE), "\n")

options(warn=owarn)
