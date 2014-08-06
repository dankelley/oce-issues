library(oce)
source('~/src/oce/R/map.R')
data(coastlineWorld)

if (!interactive()) png("518B.png", width=700, height=700, pointsize=11, type="cairo", antialias="none")

par(mfrow=c(2,2), mar=c(2, 2, 1, 1), mgp=c(2, 0.7, 0))
lon<-coastlineWorld[['longitude']]
lat<-coastlineWorld[['latitude']]

proj <- "stereographic"
mapPlot(coastlineWorld, longitudelim=c(-130,-50), latitudelim=c(60,110),
        proj=proj, fill='gray')
mtext(proj, font=2, col="purple", adj=0)

message("BUG: MUST USE 'sterea' for some reason (may be graticles)")
proj <- "+proj=sterea +lat_0=90 +north"
mapPlot(coastlineWorld, longitudelim=c(-130,-50), latitudelim=c(70,110),
        proj=proj)
mtext(proj, font=2, col="purple", adj=0)
message("FOR DOCS: skip +k -- taken care of with lat-lon limits")
message("FOR DOCS: skip easting and northing -- taken care of with lat-lon limits")

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
