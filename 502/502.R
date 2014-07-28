## https://github.com/dankelley/oce-issues/blob/master/502/502.R
if (!interactive()) png("502.png")
library(oce)
try({
    source("~/src/oce/R/landsat.R")
})

d <- read.landsat("/data/archive/landsat/LC80130272014148LGN00", band=c("red", "green", "nir"), debug=3)
plot(d, col="natural")
if (!interactive()) dev.off()

