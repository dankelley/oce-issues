if (!interactive()) png("501.png")
library(oce)
try({
    source("~/src/oce/R/landsat.R")
})
d <- read.landsat("~/google_drive/LE71910202005194ASN00",band="panchromatic", debug=3)
plot(d)
if (!interactive()) dev.off()

