require(oce)
try({source('~/src/oce/R/map.R')})
require(ocedata)
data(coastlineWorldMedium)
if (!interactive())
    png(filename="526.png" ,hei=5, wid=8, uni='in', res=600)
mapPlot(coastlineWorldMedium,
        longitudelim=c(-180,-120), latitudelim=c(35,60),
        proj="+proj=laea +lat_0=40 +lat_1=60 +lon_0=-150",
        #proj="lambert", parameters=c(lat0=40,lat1=60),  orientation=c(90, -150, 0),
        debug=3)
message("issue A: the auto-created grid is no good")
message("issue B: no axis labels on edges of box")
# mapGrid(dlat=15, dlon=15, col='red') # ok
## mapZones()
## mapMeridians(seq(35,60,by=5))
if (!interactive()) dev.off()

