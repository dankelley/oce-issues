rm(list=ls())
if (!interactive()) png("435C.png", width=7, height=7, unit="in", res=150, pointsize=12)

library(oce)
data(topoWorld)
try(source('~/src/oce/R/colors.R'), silent=TRUE)
cm <- Colormap(name="gmt_globe", blend=100)
imagep(topoWorld, breaks=cm$breaks, col=cm$col)

if (!interactive()) dev.off()

