library(oce)
if (!interactive()) png("545B.png")
data(coastlineWorld)
par(mfrow=c(1,2), mar=c(2, 2, 3, 1))
lolim <- c(-130, 50)
lalim <- c(70, 110)
options(issue545B=1) # set temporary test code in map.R (author only)
mapPlot(coastlineWorld, longitudelim=lolim, latitudelim=lalim,
        proj="stereographic", orientation=c(90, -135, 0), fill=1:5)
mtext("mapproj", adj=1)

mapPlot(coastlineWorld, longitudelim=lolim, latitudelim=lalim,
        proj="+proj=stere +lat_0=90 +lon_0=-135", fill=1:5)
mtext("proj4", adj=1)

if (!interactive()) dev.off()

