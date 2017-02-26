# from magneticField.Rd
library(oce)
if (!interactive()) png("617b.png")
## map of North American values
data(coastlineWorld)
mapPlot(coastlineWorld, longitudelim=c(-130,-55), latitudelim=c(35,60),
proj="lambert", parameters=c(lat0=40,lat1=60), orientation=c(90,-100,0))
lon <- seq(-180, 180, 1)
lat <- seq(-90, 90)
lonm <- rep(lon, each=length(lat))
latm <- rep(lat, times=length(lon))
## Note the counter-intuitive nrow argument
decl <- matrix(magneticField(lonm, latm, 2013)$declination,
               nrow=length(lon), byrow=TRUE)
mapContour(lon, lat, decl, col='red', levels=seq(-90, 90, 5))
incl <- matrix(magneticField(lonm, latm, 2013)$inclination,
               nrow=length(lon), byrow=TRUE)
mapContour(lon, lat, incl, col='blue', levels=seq(-90, 90, 5))
if (!interactive()) dev.off()
