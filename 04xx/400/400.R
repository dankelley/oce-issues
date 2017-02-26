library(oce)
load("/data/arctic/eubex1981/eubex1981.rda")
d <- ctdDecimate(eubex1981[[1]], p=seq(0,250,5))
plot(d)

