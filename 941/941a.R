rm(list=ls())
library(oce)
try(source('~/src/R-richards/oce/R/ctd.sbe.R'))

d <- read.ctd.sbe('S262-023-CTD.cnv')
