library(oce)
library(mapmisc)
data(coastlineWorld)
allEpsg <- rgdal::make_EPSG()
canadaEpsg <- allEpsg[grep("Canada", allEpsg$note), 1:2]
print(canadaEpsg)
proj <- sp::CRS("+init=epsg:3978") # one of
print(proj)
if (!interactive()) png("1078a.png", height=400)
par(mar=c(2, 2, 1, 1))
plot(coastlineWorld, proj=proj, clongitude=-90, clatitude=55, span=5000)
if (!interactive()) dev.off()

