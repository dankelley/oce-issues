library("oce") # use this for a world coastline
library("sf")
packageVersion("sf")

data(coastlineWorld, package="oce")
lonlat <- cbind(coastlineWorld[["longitude"]], coastlineWorld[["latitude"]])

longlatProj <- sf::st_crs("+proj=longlat")
proj <- sf::st_crs("+proj=ortho")
xy <- sf::sf_project(longlatProj, proj, lonlat, keep=TRUE, warn=FALSE)
plot(xy[,1], xy[,2], asp=1, type="l")
grid()
mtext(paste("sf::sf_project() results with sf version", packageVersion("sf")))
