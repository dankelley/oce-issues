library(oce)
data(coastlineWorld)
if (!interactive()) png('539C.png')
lon <- -30
par(mar=rep(1, 4), bg=NA)
p <- paste('+proj=ortho +lat_0=30 +lon_0=', lon, sep='')
mapPlot(coastlineWorld, projection=p)
mapPoints(0, 90, col='red', debug=99)

mtext("EXPECT: poles at same spot", font=2, col="purple", adj=0)
if (!interactive()) dev.off()

