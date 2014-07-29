library(oce)
## try({
##     source("~/src/oce/R/drifter.R")
##     source("~/src/oce/R/oce.R")
## })
d <- read.oce("1900617_prof.nc")
dg <- drifterGrid(d) ## was giving an error in approx()

