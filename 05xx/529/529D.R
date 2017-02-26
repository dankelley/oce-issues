# Tests from CR posting to the issue thread
library(oce)

library(ocedata)
data(coastlineWorld)
lonlim <- c(-20, 20)
latlim <- c(50, 80)

if (!interactive()) png("529D.png", height=400, width=700)
par(mfrow=c(1,2), mar=c(3, 3, 3, 1))
p <- '+proj=sterea +lat_0=90'
mapPlot(coastlineWorld, projection=p, longitudelim=lonlim, latitudelim=latlim, main=p)
p <- '+proj=sterea +lat_0=89.9'
mapPlot(coastlineWorld, projection=p, longitudelim=lonlim, latitudelim=latlim, main=p)
mtext("NB. sterea not the solution", font=2, line=0.1, col="purple", adj=0)
if (!interactive()) dev.off()

