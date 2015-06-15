n <- 10 # focus so we can see what is going on
library(oce)
data(topoWorld)
data(coastlineWorld)
lon <- topoWorld[['longitude']][1:n]
lat <- topoWorld[['latitude']][1:n]
z <- topoWorld[['z']][1:n,1:n]
llon <- expand.grid(lon, lat)[,1]
llat <- expand.grid(lon, lat)[,2]
xlim <- range(lon)
ylim <- range(lat)
if (!interactive()) png('336.png', pointsize=9)
par(mfrow=c(1, 2))
imagep(lon, lat, z, xlim=xlim, ylim=ylim)
points(llon, llat, pch=20, col='pink')
mtext("(a)", side=3, line=0, adj=1)
mapPlot(coastlineWorld, longitudelim=xlim, latitudelim=ylim)
mapImage(lon, lat, z)
mapPoints(llon, llat, pch=20, col='pink')
mtext("(b)", side=3, line=0, adj=1)
mtext("EXPECT: as (a) but projected", side=3, line=0, col='magenta', font=2, adj=0)
if (!interactive()) dev.off()
