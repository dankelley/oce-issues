library(oce)
try(source("~/src/oce/R/map.R"))
if (!interactive()) png("545.png")
data(coastlineWorld)
par(mfrow=c(1,2), mar=c(3, 3, 1, 1))
lolim <- c(-130, 50)
lalim <- c(70, 110)
mapPlot(coastlineWorld, longitudelim=lolim, latitudelim=lalim,
        proj="stereographic", orientation=c(90, -135, 0), fill='gray') 
mtext("Stereographic/mapproj", adj=1)
mapPlot(coastlineWorld, longitudelim=lolim, latitudelim=lalim,
        proj="+proj=stere +lat_0=90 +lon_0=-135", fill='gray')
mtext("Stereographic/proj4", adj=1)
if (!interactive()) dev.off()

