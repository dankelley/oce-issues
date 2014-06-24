if (!interactive()) png("475a.png")
library(oce)
try({
    source('~/src/oce/R/ctd.R')
    source('~/src/oce/R/coastline.R')
    source('~/src/oce/R/map.R')
})
data(ctd)
ctd[["longitude"]] <- -120
ctd[["latitude"]] <- 85
plot(ctd)
if (!interactive()) dev.off()

