library(oce)
data(coastlineWorld)
try(source("~/src/oce/R/map.R"))
if (!interactive()) png("543.png")
par(mfrow=c(1,2), mar=c(2, 2, 3, 1))
mapPlot(coastlineWorld, longitudelim=c(-130,50), latitudelim=c(70,110),
        proj="stereographic", orientation=c(90, -135, 0), fill='gray') 
mtext("Stereographic/mapproj", adj=1)
mtext("EXPECT: sensible meridians", font=2, col="purple", adj=0, line=1)
mtext("EXPECT: sensible axis labels", font=2, col="purple", adj=0, line=2)
mapPlot(coastlineWorld, longitudelim=c(-130,50), latitudelim=c(70,110),
        proj="+proj=stere +lat_0=90 +lon_0=-135")#, fill='gray')
mtext("Stereographic/proj4", adj=1)
mtext("EXPECT: sensible meridians", font=2, col="purple", adj=0, line=1)
mtext("EXPECT: sensible axis labels", font=2, col="purple", adj=0, line=2)
if (!interactive()) dev.off()

