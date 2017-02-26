if (!interactive()) png("521A.png", width=700, height=700, pointsize=12)
library(oce)
data(drifter)
data(topoWorld)

par(mfrow=c(2,1), mar=c(2, 2, 1, 1))
## plot(drifter)
## contour(topoWorld[["longitude"]], topoWorld[["latitude"]], topoWorld[["z"]], levels=-1000, add=TRUE)
## mtext("default", adj=1, line=0.2)
## 
## p <- "+proj=lonlat"
## plot(drifter, projection=p, fill="lightgray")
## mapContour(topoWorld, levels=-1000)
## mtext(p, adj=1, line=0.2)

p <- "+proj=merc"
plot(drifter, projection=p, fill="lightgray")
mapContour(topoWorld, levels=-1000)
mtext(p, adj=1, line=0.2)

p <- "+proj=lcc +lon_0=-40"
plot(drifter, projection=p, fill="lightgray")
mapContour(topoWorld, levels=-1000)
mtext(p, adj=1, line=0.2)

if (!interactive()) dev.off()

