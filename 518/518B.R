library(proj4)
library(oce)
source('~/src/oce/R/map.R')
data(coastlineWorld)

if (!interactive()) png("518B.png", width=8.5, height=7, unit="in", res=150, pointsize=9, type="cairo", antialias="none")

par(mfrow=c(2,2), mar=c(2, 2, 1, 1), mgp=c(2, 0.7, 0))
lon<-coastlineWorld[['longitude']]
lat<-coastlineWorld[['latitude']]

proj <- "stereographic"
mapPlot(coastlineWorld, longitudelim=c(-130,-50), latitudelim=c(60,110),
        proj=proj, fill='gray')
mtext(proj, font=2, col="purple", adj=0)

proj <- "+proj=stere" # OK (same as with +north, I think)
mapPlot(coastlineWorld, longitudelim=c(-130,-50), latitudelim=c(70,110), proj=proj)
mtext(proj, font=2, col="purple", adj=0)

## set k to 1/R_earth in 1/m
proj <- "+proj=stere +k=1.569612e-07 +lat_0=0 +y_0=-2 +north"
xy <- project(list(lon,lat), proj)
plot(xy$x, xy$y, type='l', asp=1, xlim=c(-1,1), ylim=c(-1,1))
grid()
mtext(proj, font=2, col="purple", adj=0)

proj <- "+proj=sterea +k=1.569612e-07 +lat_ts=90 +lat_0=0 +y_0=-2 +north"
xy <- project(list(lon,lat), proj)
plot(xy$x, xy$y, type='l', asp=1, xlim=c(-1,1), ylim=c(-1,1))
grid()
mtext(proj, font=2, col="purple", adj=0)

if (!interactive()) dev.off()
