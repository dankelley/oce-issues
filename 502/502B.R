## Landsat 8
if (!interactive()) png("502B.png")
library(oce)
try({
    source("~/src/oce/R/landsat.R")
})
d <- read.landsat('/data/archive/landsat/LC80130272014148LGN00', band=c('red', 'green', 'nir'), debug=3)
d <- decimate(d, by=20)
options(oceDebug=1) # also reaches into [["nir"]] etc
source("~/src/oce/R/landsat.R");system.time(plot(d, col='natural'))
mtext(paste(d[["id"]], d[["time"]]), font=2, col='purple')
if (!interactive()) dev.off()

