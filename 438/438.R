if (!interactive()) png("438.png", width=7, height=7, unit="in", res=150, pointsize=12)
library(oce)
data(ctd)
## source('~/src/oce/R/ctd.R')
plotTS(ctd, type='l', lwd=4)
if (!interactive()) dev.off()

