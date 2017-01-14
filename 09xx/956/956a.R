rm(list=ls())
library(oce)
try(source('~/src/R/oce/R/rsk.R'))

d <- read.rsk('065584_20140816_1633.rsk')
ctd <- as.ctd(d)

str(d@metadata, 1)
str(ctd@metadata, 1)
