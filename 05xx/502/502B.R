## Landsat 8
if (!interactive()) png("502B.png")
library(oce)
try({
    source("~/src/oce/R/landsat.R")
})
d <- read.landsat('/data/archive/landsat/LC80130272014148LGN00', band=c('red', 'green', 'nir'))
d <- decimate(d, by=20)
plot(d, band="terralook")
mtext(paste(d[["id"]], d[["time"]]), font=2, col='purple')
if (!interactive()) dev.off()

