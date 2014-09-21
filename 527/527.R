require(oce)
try({source('~/src/oce/R/map.R')})
require(ocedata)
data(coastlineWorldMedium)
if (!interactive())
    png(filename="527.png" ,hei=5, wid=8, uni='in', res=100)
par(mfrow=c(1,2), mar=c(2, 2, 1, 1))
mapPlot(coastlineWorldMedium,
        longitudelim=c(-180,-120), latitudelim=c(35,60),
        proj="+proj=laea +lat_0=40 +lat_1=60 +lon_0=-150",
        debug=0)
mapPlot(coastlineWorldMedium,
        longitudelim=c(-180,-120), latitudelim=c(35,60),
        proj="lambert", parameters=c(lat0=40,lat1=60),  orientation=c(90, -150, 0),
        debug=1)
# mapGrid(dlat=15, dlon=15, col='red') # ok
if (!interactive()) dev.off()

