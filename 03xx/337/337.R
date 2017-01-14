if (!interactive()) png("337.png", width=7, height=3, unit="in", res=100, pointsize=9,
                        type="cairo", antialias="none")
library(oce)
try({
    source("~/src/oce/R/landsat.R")
})

n <- 10 # focus so we can see what is going on
data(topoWorld)
data(coastlineWorld)
lon <- topoWorld[['longitude']][1:n]
lat <- topoWorld[['latitude']][1:n]
z <- topoWorld[['z']][1:n,1:n]
llon <- expand.grid(lon, lat)[,1]
llat <- expand.grid(lon, lat)[,2]
xlim <- range(lon)
ylim <- range(lat)
par(mfrow=c(1, 2))

imagep(lon, lat, z, xlim=xlim, ylim=ylim)
points(llon, llat, pch=21, bg='yellow')
mtext("(a)", adj=1)

mapPlot(coastlineWorld, longitudelim=xlim, latitudelim=ylim)
mapImage(lon, lat, z)
mapPoints(llon, llat, pch=21, bg='yellow')
mtext("EXPECT: as (a) but projected", adj=0, font=2, col='purple')
mtext("(b)", adj=1)

if (!interactive()) dev.off()

