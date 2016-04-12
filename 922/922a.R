rm(list=ls())
library(oce)
try(source('~/src/oce/R/ctd.R'))
try(source('~/src/R-richards/oce/R/ctd.R'))

d <- read.oce('dBdE_1-7.cnv')

if (!interactive()) png('922a.png')
plot(d)
if (!interactive()) dev.off()
