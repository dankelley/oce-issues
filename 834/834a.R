rm(list=ls())
library(oce)
try(source("~/src/oce/R/ctd.R"))
try(source("~/src/R-richards/oce/R/ctd.R"))

data(ctd)

if (!interactive()) png('834a-%03d.png')
plotProfile(ctd, type='p', pch=2, cex=2)
plotProfile(ctd, type='b', pch=4, cex=0.5)
if (!interactive()) dev.off()
