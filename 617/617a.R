## from old binApply.Rd (which now uses proj4)
library(oce)
#try(source("~/src/oce/R/map.R"))
if (!interactive()) png("617a.png")
data(secchi, package="ocedata")
col <- rev(oce.colorsJet(100))[rescale(secchi$depth, xlow=0, xhigh=20, rlow=1, rhigh=100)]
zlim <- c(0, 20)
breaksPalette <- seq(min(zlim), max(zlim), 1)
colPalette <- rev(oce.colorsJet(length(breaksPalette)-1))
drawPalette(zlim, "Secchi Depth", breaksPalette, colPalette)
data(coastlineWorld)
mapPlot(coastlineWorld, longitudelim=c(-5,20), latitudelim=c(50,66),
        grid=5, fill='gray', proj="lambert", parameters=c(lat0=50, lat1=65))
bc <- binApply2D(secchi$longitude, secchi$latitude,
                 pretty(secchi$longitude, 80),
                 pretty(secchi$latitude, 40),
                 f=secchi$depth, FUN=mean)
mapImage(bc$xmids, bc$ymids, bc$result, zlim=zlim, col=colPalette)
mapPolygon(coastlineWorld, col='gray')
if (!interactive()) dev.off()
