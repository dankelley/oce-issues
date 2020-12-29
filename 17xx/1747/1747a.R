library(oce)
data(coastlineWorldFine, package="ocedata")
lonlim <- c(-75, -5)
latlim <- c(35, 45)
if (!interactive())
    png("1747a.png")
par(mar=c(2,2,1,1))
mapPlot(coastlineWorldFine,
        projection="+proj=lcc +lon_0=-30 +lat_1=27 +lat_2=47",
        longitudelim=lonlim, latitudelim=latlim, col="tan")
if (!interactive())
    dev.off()

