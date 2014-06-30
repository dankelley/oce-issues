if (!interactive()) png("477b.png")
library(oce)
try({
    source('~/src/oce/R/coastline.R')
    source('~/src/oce/R/map.R')
})
data(coastlineWorld)
#plot(coastlineWorld, clat=45, clon=-63, span=3000, projection=FALSE) #"none")#"mercator")
plot(coastlineWorld, clat=45, clon=-63, span=3000, projection='mercator')
mapScalebar(x="topright")
if (!interactive()) dev.off()

