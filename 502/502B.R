if (!interactive()) png("502B.png")
library(oce)
try({
    source("~/src/oce/R/landsat.R")
})
d <- read.landsat('/data/archive/landsat/LC80130272014148LGN00', band=c('red', 'green', 'nir'), debug=3)
d <- decimate(d, by=20)
# options(landsat=1) # TEST -- try 1 through 5 (see R/landsat.R)
plot(d, col='natural', debug=3)
mtext(paste(d[["id"]], d[["time"]]), font=2, col='purple')
if (!interactive()) dev.off()

