library(oce)
load("/data/arctic/eubex1981/eubex1981.rda")
source('~/src/R-kelley/oce/R/ctd.R')
d <- ctdDecimate(eubex1981[[1]], p=seq(0,250,5))
plot(d)

