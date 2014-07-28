## Landsat 7
if (!interactive()) png("502A.png")
library(oce)
try({
    source("~/src/oce/R/landsat.R")
})
d <- read.landsat("/data/archive/landsat/LE71910202005194ASN00", band=c("red", "green", "nir"))
d <- decimate(d, by=20)
plot(d, col="natural", debug=3)
mtext(paste(d[["id"]], d[["time"]]), font=2, col='purple')
if (!interactive()) dev.off()

