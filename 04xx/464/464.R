if (!interactive()) png("464.png", height=300)
library(oce)
library(plyr) # for laply
data(section)
stations <- section[["station"]]
lon <- laply(seq_along(stations), function(i) stations[[i]][["longitude"]])
lat <- laply(seq_along(stations), function(i) stations[[i]][["latitude"]])
SST <- laply(seq_along(stations), function(i) stations[[i]][["temperature"]][1])
SST <- smooth(SST)                     # get rid of some quirky features
cm <- colormap(z=SST)
par(mar=c(2, 2, 1, 1))
omar <- par('mar')                     # allows interactive source()
drawPalette(colormap=cm)
mapPlot(lon, lat, col=cm$zcol,
        latitudelim=c(40,50), longitudelim=c(-80, 0),
        grid=10, type='p')
data(coastlineWorldFine, package="ocedata")
mapLines(coastlineWorldFine)
mtext("SST along WOCE line A03", side=3)
par(mar=omar) # return to original (see above)
if (!interactive()) dev.off()
