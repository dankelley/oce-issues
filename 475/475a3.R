if (!interactive()) png("475a3.png")
library(oce)
try({
    source('~/src/oce/R/ctd.R')
    source('~/src/oce/R/coastline.R')
    source('~/src/oce/R/map.R')
})
data(ctd)
ctd[["longitude"]] <- -70
ctd[["latitude"]] <- 30
plot(ctd, which="map")#, span=5000, debug=10)
if (!interactive()) dev.off()

