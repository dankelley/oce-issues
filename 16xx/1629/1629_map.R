library(oce)
debug <- 4 # actually, I think 3 goes all the way to the core
data(coastlineWorld)
options("oce:test_sf"=1)
if (!interactive()) png("1629_map.png")
par(mar=rep(0.5, 4))
mapPlot(coastlineWorld, projection="+proj=moll", debug=debug)
if (!interactive()) dev.off()
