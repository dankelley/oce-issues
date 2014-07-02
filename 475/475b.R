if (!interactive()) png("475b.png")
library(oce)
try({
    source('~/src/oce/R/ctd.R')
    source('~/src/oce/R/coastline.R')
    source('~/src/oce/R/map.R')
})
data(ctd)
ctd[['latitude']] <- 80
ctd[['longitude']] <- 0
plot(ctd, which="map")
if (!interactive()) dev.off()
