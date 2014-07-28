if (!interactive()) png("502.png")
library(oce)
try({
    source("~/src/oce/R/landsat.R")
})
d <- read.landsat("/data/archive/landsat/LE71910202005194ASN00",
                  band=c("red", "green", "blue"), debug=3)
plot(d, col="natural")
if (!interactive()) dev.off()

