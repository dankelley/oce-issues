rm(list=ls())
library(oce)

d <- read.oce('~/Dropbox/oce-working-notes/CNV/JR302_001_align_ctm.cnv')
dt <- ctdTrim(d)
dsbe <- ctdTrim(d, method="sbe", parameters=list(minSoak=5))

if (!interactive()) png('1104b.png')

xlim <- c(0, 15000)
ylim <- c(0, 75)
par(mfrow=c(3, 1))
plotScan(d, xlim=xlim, ylim=ylim)
title("Original data")
plotScan(d, xlim=xlim, ylim=ylim, col='lightgrey')
lines(dt[['scan']], dt[['pressure']])
title("Default ctdTrim()")
plotScan(d, xlim=xlim, ylim=ylim, col='lightgrey')
lines(dsbe[['scan']], dsbe[['pressure']])
title("SBE method (minSoak=5, maxSoak=20)")

if (!interactive()) dev.off()
