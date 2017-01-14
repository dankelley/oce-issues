library(oce)
try(source("~/src/oce/R/drifter.R"))
if (!interactive()) png("548.png")
drifter <- read.oce("R20141102_prof.nc")
plot(drifter)
if (!interactive()) dev.off()

