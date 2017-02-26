rm(list=ls())
library(oce)

d <- read.oce('dBdE_1-7.cnv')

if (!interactive()) png('922a.png')
plot(d)
if (!interactive()) dev.off()
