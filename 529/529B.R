# Tests from CR posting to the issue thread
library(oce)
try({source('~/src/oce/R/map.R')})

library(ocedata)
data(coastlineWorld)
lonlim <- c(-20, 20)
latlim <- c(50, 80)

if (!interactive()) png("529B.png")
par(mfrow=c(1,2), mar=c(3, 3, 3, 1))
p <- "stereographic"
mapPlot(coastlineWorld, projection=p, longitudelim=lonlim, latitudelim=latlim, main=p)
p <- '+proj=stere +lat_0=90'
mapPlot(coastlineWorld, projection=p, longitudelim=lonlim, latitudelim=latlim, main=p)
mtext("NB. lat_0 fixes curved meridians", font=2, line=0.1, col="purple", adj=0)
if (!interactive()) dev.off()

