library(oce)
library(gsw)
data(coastlineWorld)

## generate a vector for a grid of points on the Earth
lo <- seq(-180, 180, 1)
la <- seq(-90, 90, 1)
lon <- expand.grid(lo, la)[,1]
lat <- expand.grid(lo, la)[,2]

SA <- array(gsw_SA_from_SP(rep(35, length(lon)),
                           rep(100, length(lon)), lon, lat),
            dim=c(length(lo), length(la)))

if (!interactive()) png('655c.png', width=7*72, height=4*72, type='cairo')

# par(mfrow=c(2,1), mar=rep(1, 4))
par(mar=rep(1, 4))

mapPlot(coastlineWorld)
mapImage(lo, la, SA, missingColor=NA, col=oceColorsJet)
mtext("Expect: no horizontal rainbow near top of plot", side=3, line=0, font=2, col="magenta", adj=0)

if (!interactive()) dev.off()
