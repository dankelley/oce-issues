rm(list=ls())
library(oce)

d <- read.ctd('pisces.cnv')
if (!interactive()) png('903a.png')
plot(d)
if (!interactive()) dev.off()
