## At-satelight brightness temperature; algorithm from
##   http://landsat.usgs.gov/Landsat8_Using_Product.php
if (!interactive()) png("478_%d.png", width=7, height=7, unit="in", res=100, pointsize=10)
library(oce)
try({
    source('~/src/oce/R/landsat.R')
})
files <- c("~/google_drive/LC80060292013272LGN00", "~/google_drive/LC80080292014065LGN00",
           "~/google_drive/LC80120262013282LGN00")
for (file in files) {
    i <- read.landsat(file, band="tirs1", debug=10)
    d <- i[["band", "tirs1"]]
    ML <- i@metadata$header$radiance_mult_band_10
    AL <- i@metadata$header$radiance_add_band_10
    d <- d * 65535                         # convert from range 0 to 1
    Llambda <- ML * d + AL
    K1 <- i@metadata$header$k1_constant_band_10
    K2 <- i@metadata$header$k2_constant_band_10
    dd <- K2 / (log(K1 / Llambda + 1))
    SST <- dd - 273.15                     # convert Kelvin to Celcius
    i@data$SST <- SST
    plot(i, band="SST")
    mtext(i[["time"]], side=3)
}
if (!interactive()) dev.off()
