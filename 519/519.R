if (!interactive()) png("519.png")
library(oce)
try({
    source("~/src/oce/R/landsat.R")
})
i <- read.landsat("/data/archive/landsat/LE71910202005194ASN00", band="tirs1")
#i <- decimate(i, by=33)
plot(i, band="temperature")
if (!interactive()) dev.off()
