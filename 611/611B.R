library(marmap)
library(oce)
try(source("~/src/oce/R/map.R"))
try(source("~/src/oce/R/topo.R"))
a <- getNOAA.bathy(-100, 0, 00, 60, resolution=120)
t <- as.topo(a)
if (!interactive()) png("611B.png")
par(mfrow=c(2, 2))
plot(t, location="none", xlim=c(-140,0))
plot(t, xlim=c(-140,0))
mapPlot(t, proj="+proj=merc", latitudelim=c(0,60))
if (!interactive()) dev.off()


