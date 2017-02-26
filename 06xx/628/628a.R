library(oce)
sessionInfo()
if (!interactive()) png("628a.png")
data(coastlineWorld)
lon <- coastlineWorld[["longitude"]]
lat <- coastlineWorld[["latitude"]]
xy <- lonlat2map(lon, lat, projection="+proj=wintri")
plot(xy$x, xy$y, type='l', asp=1)
#mapPlot(coastlineWorld, proj="+proj=wintri", grid=FALSE)
if (!interactive()) dev.off()
