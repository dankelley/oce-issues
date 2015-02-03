library(oce)
try(source("~/src/oce/R/map.R"))
data(coastlineWorld)
longitudelim <- c(-180,-125)
latitudelim <- c(45,55)
if (!interactive()) png("01.png")
mapPlot(coastlineWorld, longitudelim=longitudelim, latitudelim=latitudelim,
        proj="+proj=lcc +lat_0=40 +lat_1=60 +lon_0=-150",  grid=c(10,10),
        axes=FALSE)
mapGrid(dlongitude=5, dlatitude=5)
mapAxis(side=1, tcl=-0.5, col.ticks='blue') # wild values to show effect
mapAxis(side=2, col.ticks='red', lwd.ticks=5) # wild values to show effect
if (!interactive()) dev.off()

