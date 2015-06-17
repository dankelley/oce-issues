library(oce)
data(coastlineWorld)
lon <- -20:20
lat <- -20:20
lo <- expand.grid(lon, lat)[,1]
la <- expand.grid(lon, lat)[,2]
f <- matrix(exp(-(lo^2 + la^2)/2/10) + .Machine$double.eps*rnorm(lo), nrow=length(lon)) # create fake 2d gaussian
if (!interactive()) png("309A.png")
par(mar=c(2, 2, 1, 1))
mapPlot(coastlineWorld, latitudelim=range(lat), longitudelim=range(lon))
mapImage(lon, lat, f, col=oceColorsJet, zlim=c(0, 1))
mapPolygon(coastlineWorld, col='grey')
mtext("EXPECT: projected rectangle, with dark red in centre", side=3, line=0, adj=0, font=2, col='magenta')
if (!interactive()) dev.off()
