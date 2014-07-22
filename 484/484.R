library(oce)
try({
    source("~/src/oce/R/landsat.R")
    source("~/src/oce/R/imagep.R")
})
l <- read.landsat('~/google_drive/LC80080292014065LGN00', band=8)
plot(l, debug=5)                       # gobbles memory and hangs (4GB RAM) machine
