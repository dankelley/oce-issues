library(marmap)
library(oce)
try(source("~/src/oce/R/map.R"))
try(source("~/src/oce/R/topo.R"))
a <- getNOAA.bathy(-65, -60, 40, 45)
t <- as.topo(a)
if (!interactive()) png("611B.png")
mapPlot(t, proj="+proj=merc")
if (!interactive()) dev.off()


