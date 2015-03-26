library(marmap)
library(oce)
try(source("~/src/oce/R/map.R"))
try(source("~/src/oce/R/topo.R"))
a <- getNOAA.bathy(-70, -60, 40, 50, resolution=10)
t <- as.topo(a)
if (!interactive()) png("611B.png")
par(mfrow=c(1,2))
plot(t)
mapPlot(t, proj="+proj=merc", grid=2, latitudelim=c(40,50))
if (!interactive()) dev.off()


