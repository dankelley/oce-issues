library(oce)
source('~/src/oce/R/map.R')
data(coastlineWorld)

if (!interactive()) png("01.png")
par(mfrow=c(2,2), mar=rep(0.5, 4)) # leaves one slot empty

mapPlot(coastlineWorld, projection="mollweide", fill="gray")
## Near to it's "mirror" in Southern hemisphere: great circle will cross meridians
mapPoints(rep(-63, 19), seq(-45, 45, 5), pch=20, col='red')
mapLines(c(-63, -63), c(-45, 45), col='blue', lwd=2)
mapText(-63, 44, "Halifax", font=2, col='red', pos=3)

mapPolygon(coastlineWorld, col=rgb(1, 1, 1, alpha=0.7)) # check alpha on dots
data(topoWorld)
topoWorld <- decimate(topoWorld, by=10)
mapContour(topoWorld, levels=1000, col='red') # SLOW
library(ncdf4)
con <- nc_open("/data/oar/levitus/temperature_annual_5deg.nc")
lon <- ncvar_get(con, "lon")
lat <- ncvar_get(con, "lat")
SST <- ncvar_get(con, "t_mn")[,,1]
Tlim <- c(-2, 30)

## OLD
mapPlot(coastlineWorld, projection="mollweide", fill="gray")
mapImage(lon, lat, SST, col=oceColorsJet, zlim=Tlim)
mapPolygon(coastlineWorld, col='gray')
mtext("using mapproj", adj=0, font=2, col="purple")

mapPlot(coastlineWorld, projection="+proj=moll", fill="gray")
mapImage(lon, lat, SST, col=oceColorsJet, zlim=Tlim)
mapPolygon(coastlineWorld, col='gray')
mtext("using proj4", adj=0, font=2, col="purple")

if (!interactive()) dev.off()

