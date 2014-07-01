## At-satelight brightness temperature; algorithm from
##   http://landsat.usgs.gov/Landsat8_Using_Product.php
if (!interactive()) png("478_%d.png", width=7, height=7, unit="in", res=100, pointsize=10)
library(oce)
try({
    source('~/src/oce/R/oce.R')
    source('~/src/oce/R/landsat.R')
})
setwd("~/google_drive")
files <- c("LC80060292013272LGN00", "LC80080292014065LGN00", "LC80120262013282LGN00")
for (file in files) {
    message("file: ", file)
    l <- read.landsat(file, band="tirs1", debug=10)
    tirs1 <- l[["tirs1"]]
    ML <- l@metadata$header$radiance_mult_band_10
    AL <- l@metadata$header$radiance_add_band_10
    K1 <- l@metadata$header$k1_constant_band_10
    K2 <- l@metadata$header$k2_constant_band_10
    d <- tirs1 * (2^16 - 1)            # convert from range 0 to 1
    Llambda <- ML * d + AL
    dd <- K2 / (log(K1 / Llambda + 1))
    SST <- dd - 273.15                 # convert Kelvin to Celcius
    l@data$SST <- SST
    plot(l, band="SST", col=oceColorsJet)
    mtext(l[["time"]])
}
if (!interactive()) dev.off()
