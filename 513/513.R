## Landsat 8
library(oce)
try({
    source("~/src/oce/R/landsat.R")
})
d <- read.landsat('/data/archive/landsat/LC80130272014148LGN00', band='tirs1')
d <- decimate(d, by=33) # because temp plot does not decimate and is SLOW
#options(oceDebug=2) # get debugging in [["temperature"]]
plot(d, band="temperature")
