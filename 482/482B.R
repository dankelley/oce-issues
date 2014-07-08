if (!interactive()) png("482.png")
library(oce)
try({
    source('~/src/oce/R/landsat.R')
})
options(testLandsat1=TRUE)
system.time(l <- read.landsat("~/Downloads/LC80150282014178LGN00", band="tirs1"))
tirs1 <- l[["tirs1"]]
ML <- l@metadata$header$radiance_mult_band_10
AL <- l@metadata$header$radiance_add_band_10
K1 <- l@metadata$header$k1_constant_band_10
K2 <- l@metadata$header$k2_constant_band_10
print(ML)
print(ML)
print(K1)
print(K2)
d <- tirs1 * (2^16 - 1)            # convert from range 0 to 1
Llambda <- ML * d + AL
dd <- K2 / log(K1 / Llambda + 1)
SST <- dd - 273.15                 # convert Kelvin to Celcius
l@data$SST <- SST
plot(l, band="SST", col=oceColorsJet)
mtext(l[["time"]])
if (!interactive()) dev.off()
