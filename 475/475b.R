if (!interactive()) png("475b.png")
library(oce)
try({
    source('~/src/oce/R/ctd.R')
    source('~/src/oce/R/coastline.R')
    source('~/src/oce/R/map.R')
})
data(ctd)
ctd[["longitude"]] <- -120
ctd[["latitude"]] <- 85
plot(ctd, which="map")
if (!interactive()) dev.off()
