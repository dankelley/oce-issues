if (!interactive()) png("454.png", width=7, height=7, unit="in", res=150, pointsize=9)
library(oce)
data(levitus, package="ocedata")
library(oce)                           # drawPalette() mapPlot() mapImage()
Tlim <- c(-2, 30)                      # temperature range
par(mar=rep(1, 4))                     # narrow the margins
par(mfrow=c(2,1))
omar <- par('mar')
drawPalette(Tlim, col=oceColorsJet)    # like matlab "jet" scheme

# Draw the coastline with Mollweide projection
data(coastlineWorld)
mapPlot(coastlineWorld, projection="mollweide", grid=FALSE)

# Add the SST
mapImage(levitus$longitude, levitus$latitude, levitus$SST,
         col=oceColorsJet, zlim=Tlim, missingColor='lightgray')

cm <- colormap(zlim=Tlim, col=oceColorsJet)
par(mar=omar)
drawPalette(Tlim, colormap=cm)    # like matlab "jet" scheme
mapPlot(coastlineWorld, projection="mollweide", grid=FALSE)
mapImage(levitus$longitude, levitus$latitude, levitus$SST,
         colormap=cm)

if (!interactive()) dev.off()
