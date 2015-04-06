rm(list=ls())
library(oce)

d <- read.oce('../622/a.rsk')
S <- d[['salinity']]
C <- d[['conductivity']]/42.914
T <- d[['temperature']]
p <- d[['pressure']]

dd <- as.ctd(S, T, p, C)
stopifnot(!is.null(dd[['conductivity']]))
