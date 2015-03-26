library(oce)
Tlim <- c(-2, 30)
par(mar=c(1, 1, 1, 1))
mapPlot(coastlineWorld, projection='mollweide', grid=FALSE, col='gray')
DX <- diff(par('usr')[1:2])
data(levitus)
mapContour(levitus[['longitude']], levitus[['latitude']],
         levitus[['SST']], lwd=2, col='blue')
mapZones()
mapMeridians()

