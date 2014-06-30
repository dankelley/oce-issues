if (!interactive()) png("477b.png")
library(oce)
try({
    source('~/src/oce/R/coastline.R')
    source('~/src/oce/R/map.R')
})
data(coastlineWorldFine, package="ocedata")
plot(coastlineWorldFine, clat=45, clon=-63, span=3000, projection='mercator')
mapScalebar(x="topright")
mapScalebar(x="topleft")
if (!interactive()) dev.off()

