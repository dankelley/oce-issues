if (!interactive()) png("454b.png", width=7, height=4, unit="in", res=150, pointsize=9)
library(oce)
data(levitus, package="ocedata")
library(oce)
Tlim <- c(-2, 30)
par(mar=rep(1, 4))
omar <- par('mar')

# Draw the coastline with Mollweide projection
data(coastlineWorld)
mapPlot(coastlineWorld, projection="mollweide", grid=FALSE)
cm <- colormap(zlim=Tlim, col=oceColorsJet)
drawPalette(Tlim, colormap=cm)
mapPlot(coastlineWorld, projection="mollweide", grid=FALSE)
mapImage(levitus$longitude, levitus$latitude, levitus$SST,
         colormap=cm)
par(mar=omar)                          # a good habit, although not needed

if (!interactive()) dev.off()
