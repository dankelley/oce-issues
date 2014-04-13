library(oce)
message("424.R only works for DK, who has certain data files")
load("landsat.rda")
source('~/src/oce/R/imagep.R')
source('~/src/oce/R/landsat.R')

#OK plot(landsat, which=2, zlim=c(0.10, 0.15))
plot(landsat, which=2, zlim="histogram")

