if (!interactive()) png("509.png")
library(oce)
try({
    source("~/src/oce/R/landsat.R")
})
options(oceDebug=3)
l <- read.landsat('/data/archive/landsat/LE71910202005194ASN00', band="red")
im <- l[["red"]] / 2^16-1
l <- landsatAdd(l, im, 'tc')
summary(l)
plot(l, band="tc")
if (!interactive()) dev.off()

