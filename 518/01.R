library(oce)
source('~/src/oce/R/map.R')
data(coastlineWorld)
data(topoWorld)
topoWorld <- decimate(topoWorld, by=10)

if (!interactive()) png("518A.png", width=700, height=700, pointsize=11, type="cairo", antialias="none")

par(mfrow=c(2,2), mar=c(1, 1, 1.5, 1)) # leaves one slot empty

proj <- "mollweide"
mapPlot(coastlineWorld, projection=proj, fill="gray")
## Near to it's "mirror" in Southern hemisphere: great circle will cross meridians
mapPoints(rep(-63, 19), seq(-45, 45, 5), pch=20, col='red')
mapLines(c(-63, -63), c(-45, 45), col='blue', lwd=2)
mapText(-63, 44, "Halifax", font=2, col='red', pos=3)
mapPolygon(coastlineWorld, col=rgb(1, 1, 1, alpha=0.7)) # check alpha on dots
mapContour(topoWorld, levels=1000, col='red') # SLOW
mtext(proj, font=2, col="purple", adj=0)


proj <- "+proj=moll"
mapPlot(coastlineWorld, projection=proj, fill="gray")
## Near to it's "mirror" in Southern hemisphere: great circle will cross meridians
mapPoints(rep(-63, 19), seq(-45, 45, 5), pch=20, col='red')
mapLines(c(-63, -63), c(-45, 45), col='blue', lwd=2)
mapText(-63, 44, "Halifax", font=2, col='red', pos=3)
mapPolygon(coastlineWorld, col=rgb(1, 1, 1, alpha=0.7)) # check alpha on dots
mapContour(topoWorld, levels=1000, col='red') # SLOW
mtext(proj, font=2, col="purple", adj=0)

library(ncdf4)
con <- nc_open("/data/oar/levitus/temperature_annual_5deg.nc")
lon <- ncvar_get(con, "lon")
lat <- ncvar_get(con, "lat")
SST <- ncvar_get(con, "t_mn")[,,1]
Tlim <- c(-2, 30)

## OLD
proj <- "mollweide"
mapPlot(coastlineWorld, projection=proj, fill="gray")
mapImage(lon, lat, SST, col=oceColorsJet, zlim=Tlim)
mapPolygon(coastlineWorld, col='gray')
mtext(proj, font=2, col="purple", adj=0)

proj <- "+proj=moll"
mapPlot(coastlineWorld, projection=proj, fill="gray")
mapImage(lon, lat, SST, col=oceColorsJet, zlim=Tlim)
mapPolygon(coastlineWorld, col='gray')
mtext(proj, font=2, col="purple", adj=0)

if (!interactive()) dev.off()

