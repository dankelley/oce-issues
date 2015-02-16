library(oce)
## source("~/src/oce/R/ctd.R")
f <- '050107_20130620_2245cast4.rsk'
d <- read.oce('050107_20130620_2245cast4.rsk')
if (!interactive()) png("588C_%d.png")
plotScan(d)
title(f)
plotScan(ctdTrim(d))
plotScan(subset(d, 1010 < scan & scan < 1070), type='p')
title(paste(f, "after ctdTrim()"))
if (!interactive()) dev.off()

