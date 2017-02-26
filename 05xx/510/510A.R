library(oce)
d <- read.oce("1900617_prof.nc")
dg <- drifterGrid(d) ## was giving an error in approx()

