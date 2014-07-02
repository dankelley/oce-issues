if (!interactive()) png("475a2.png")
library(oce)
try({
    source('~/src/oce/R/ctd.R')
    source('~/src/oce/R/coastline.R')
    source('~/src/oce/R/map.R')
})
data(ctd)
ctd[["longitude"]] <- 0
ctd[["latitude"]] <- 80
plot(ctd, debug=4)
if (!interactive()) dev.off()

