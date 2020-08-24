library(oce)
source("~/git/oce-sf/R/map.R")
data(coastlineWorld)

axisStyle <- 2
if (TRUE) {
    mapPlot(coastlineWorld,
            longitudelim=c(-10,10),
            latitudelim=c(40,60),
            col="tan",
            projection="+proj=aea +lat_1=20 +lat_2=50",
            axisStyle=axisStyle)
}

if (TRUE) {
    mapPlot(coastlineWorld,
            col="tan",
            projection="+proj=moll",
            axisStyle=axisStyle)
}
