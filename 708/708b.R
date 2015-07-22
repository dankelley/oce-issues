rm(list=ls())
library(oce)
library(ocedata)
data(coastlineWorld)
data(coastlineWorldFine)
data(topoWorld)

if (!interactive()) png('708b.png')

par(mar=rep(2, 4))

asp <- 1/cos(45*pi/180)
plot(coastlineWorldFine[["longitude"]],
     coastlineWorldFine[["latitude"]],
     asp=asp, type='l',
     xlim = c(-75, -50), ylim = c(35, 55))

tlon <- topoWorld[["longitude"]]
tlon <- ifelse(tlon > 180, tlon-360, tlon)
look <- 361:720
contour(tlon[look],
        topoWorld[["latitude"]],
        topoWorld[["z"]][look,], levels=-250, lwd=2, col=2, add=TRUE)

if (!interactive()) dev.off()
