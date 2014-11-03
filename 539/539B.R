library(oce)
data(coastlineWorld)
if (!interactive()) png('539B-%03d.png')
lons <- seq(179, -179, -10)
options(oceProj4Test=1)
for (lon in lons[1:3]) {
  par(mar=rep(1, 4), bg=NA)
  p <- paste('+proj=ortho +lat_0=30 +lon_0=', lon, sep='')
  mapPlot(coastlineWorld, projection=p)
  mapPoints(0, 90, col='red')
  mtext(p, adj=1)
}
mtext("EXPECT: poles at same spot", font=2, col="purple", adj=0)
if (!interactive()) dev.off()
