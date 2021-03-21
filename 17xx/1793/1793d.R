library(oce)
packageVersion("sf")
data(coastlineWorld)
proj <- "+proj=ortho"
ll <- cbind(coastlineWorld[["longitude"]], coastlineWorld[["latitude"]])
xy <- oceProject(ll, proj, debug=3)
par(mfrow=c(1, 2))
plot(xy[,1],xy[,2],asp=1,type="l")
mtext(paste0("oce::mapPlot(..., proj=\"", proj, "\")"))
longlatProj <- sf::st_crs("+proj=longlat")$proj4string
xy_sf <- sf::sf_project(longlatProj, proj, ll, keep=TRUE, warn=FALSE)
plot(xy_sf[,1], xy_sf[,2], asp=1, type="l")
mtext(paste("sf::sf_project with sf version", packageVersion("sf")))
