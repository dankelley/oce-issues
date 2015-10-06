rm(list=ls())
library(oce)
library(ncdf4)
## source('~/src/R-richards/oce/R/argo.R')

d <- read.oce('6900835_prof.nc')
nc <- nc_open('6900835_prof.nc')
