## Landsat 8
library(oce)
try({
    source("~/src/oce/R/landsat.R")
})
d <- read.landsat('/data/archive/landsat/LC80130272014148LGN00', band='red')
plot(d, band="temperature")

