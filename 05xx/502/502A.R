## Landsat 7
if (!interactive()) png("502A.png")
library(oce)
d <- read.landsat("/data/archive/landsat/LE71910202005194ASN00", band=c("red", "green", "nir"))
d <- decimate(d, by=20)
plot(d, band="terralook")
mtext(paste(d[["id"]], d[["time"]]), font=2, col='purple')
if (!interactive()) dev.off()

