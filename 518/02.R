library(oce)
source('~/src/oce/R/map.R')
data(coastlineWorld)

if (!interactive()) png("02.png")
par(mfrow=c(2,2), mar=c(2, 2, 1, 1), mgp=c(2, 0.7, 0))
lon<-coastlineWorld[['longitude']]
lat<-coastlineWorld[['latitude']]
#xy<-project(list(lon,lat),"+proj=sterea +k=1.569612e-07 +lat_0=89.99 +lon_0=-120 +x_0=0 +y_0=0")
## set k to 1/R_earth in 1/m
xy<-project(list(lon,lat),"+proj=sterea +k=1.569612e-07 +lat_0=0 +lon_0=-135 +y_0=-2 +north")
## maybe mapproj is in unit sphere, so try to emulate by dividing by 6371e3 m
plot(xy$x, xy$y, type='l', asp=1, xlim=c(-1,1), ylim=c(-1,1))
grid()
mtext("proj4 (directly)", line=-1, font=2, col="purple", adj=0)

## mapPlot(coastlineWorld, longitudelim=c(-130,-50), latitudelim=c(70,110),
##         proj="+proj=sterea +k=1.569612e-07 +lat_0=0 +lon_0=-120 +x_0=0 +y_0=-2",
##         orientation=c(90, -120, 0), fill='gray')
## mapPlot(coastlineWorld, longitudelim=c(-200,-60), latitudelim=c(70,90),
##         proj="+proj=sterea +k=1.569612e-07 +lat_0=0 +lon_0=-120 +x_0=0 +y_0=0",
##         orientation=c(90, -120, 0), fill='gray')
mapPlot(coastlineWorld, longitudelim=c(-130,-50), latitudelim=c(70,110),
        proj="+proj=sterea +lat_0=89.9 +lon_0=0 +y_0=-2 +north")#, fill='gray')
mtext("bad centring; curved meridians", font=2, col="purple", adj=0)
mtext("proj4", font=2, line=-1, col="purple", adj=0)
message("FOR DOCS: skip +k -- taken care of with lat-lon limits")
message("FOR DOCS: skip easting and northing -- taken care of with lat-lon limits")

mapPlot(coastlineWorld, longitudelim=c(-130,-50), latitudelim=c(70,110),
        proj="stereographic", fill='gray')
mtext("straight meridians", font=2, col="purple", adj=0)
mtext("mapproj4", font=2, line=-1, col="purple", adj=0)

if (!interactive()) dev.off()
