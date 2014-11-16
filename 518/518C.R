library(oce)
library(proj4)
source('~/src/oce/R/map.R')
data(coastlineWorld)

if (!interactive()) png("518C.png", width=8.5, height=7, unit="in", res=150, pointsize=9, type="cairo", antialias="none")

par(mfrow=c(3,2), mar=c(3, 3, 1.5, 1))
lon<-coastlineWorld[['longitude']]
lat<-coastlineWorld[['latitude']]
#xy<-project(list(lon,lat),"+proj=sterea +k=1.569612e-07 +lat_0=89.99 +lon_0=-120 +x_0=0 +y_0=0")
## set k to 1/R_earth in 1/m

proj <- "+proj=moll +k=1.569612e-07 +lat_0=0 +lon_0=0 +x_0=0 +y_0=0"
xy <- project(list(lon,lat), proj)
## maybe mapproj is in unit sphere, so try to emulate by dividing by 6371e3 m
plot(xy$x, xy$y, type='l', asp=1)#, xlim=c(-1,1), ylim=c(-1,1))
abline(h=0, col='red')
abline(v=0, col='red')
mtext(proj, font=2, col="purple", adj=0)

xy <- project(list(lon,lat),"+proj=moll +k=1.569612e-07 +lat_0=0 +lon_0=-120 +x_0=0 +y_0=0")
## maybe mapproj is in unit sphere, so try to emulate by dividing by 6371e3 m
plot(xy$x, xy$y, type='l', asp=1)#, xlim=c(-1,1), ylim=c(-1,1))
abline(h=0, col='red')
abline(v=0, col='red')
#mtext("new before unweirding", adj=0, font=2, col='purple')
mtext(proj, font=2, col="purple", adj=0)

## mapPlot(coastlineWorld, longitudelim=c(-130,-50), latitudelim=c(70,110),
##         proj="+proj=sterea +k=1.569612e-07 +lat_0=0 +lon_0=-120 +x_0=0 +y_0=-2",
##         orientation=c(90, -120, 0), fill='gray')
## mapPlot(coastlineWorld, longitudelim=c(-200,-60), latitudelim=c(70,90),
##         proj="+proj=sterea +k=1.569612e-07 +lat_0=0 +lon_0=-120 +x_0=0 +y_0=0",
##         orientation=c(90, -120, 0), fill='gray')
mapPlot(coastlineWorld, #longitudelim=c(-130,-50), latitudelim=c(70,110),
        proj="+proj=moll +lat_0=0 +lon_0=0 +x_0=0 +y_0=0",
        fill='gray')
mtext(proj, font=2, col="purple", adj=0)

proj <- "+proj=moll +lat_0=0 +lon_0=-120 +x_0=0 +y_0=0"
mapPlot(coastlineWorld, #longitudelim=c(-130,-50), latitudelim=c(70,110),
        proj=proj, fill='gray')
mtext(proj, font=2, col="purple", adj=0)

proj <- "mollweide"
mapPlot(coastlineWorld, projection=proj, fill='gray')
mtext(proj, font=2, col="purple", adj=0)

mapPlot(coastlineWorld, projection="mollweide", orientation=c(90, -120, 0), fill='gray')
mtext(proj, font=2, col="purple", adj=0)

if (!interactive()) dev.off()
