## Try correcting for thermal emissivity 
if (!interactive()) png("482B.png")
library(oce)
try({
    source('~/src/oce/R/landsat.R')
})
if (!exists("tirs1")) {
    l <- read.landsat("~/Downloads/LC80150282014178LGN00", band="tirs1", debug=10)
    tirs1 <- l[["tirs1"]]
}
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
TB <- K2 / log(K1 / Llambda + 1)       # brightness temperature
## correct for emissivity, assuming soil; see the yellow box at bottom of 
## the following webpage
## http://fromgistors.blogspot.ca/2014/01/estimation-of-land-surface-temperature.html
## values for soil, grass, asphalt and concrete below; may select one if known
epsilon <- mean(c(0.928, 0.982, 0.942, 0.937))
epsilon <- 0.982                       # grass
epsilon <- 0.937                       # concrete
lambda <- 10.8e-6 # for band 10; again see fromgistors
rho <- 1.438e-2 # see fromgistors
T <- TB / (1 + (lambda * TB / rho) * log(epsilon))
temperature <- TB - 273.15             # convert Kelvin to Celcius
temperature <- T - 273.15              # convert Kelvin to Celcius
l@data$temperature <- temperature
plot(l, band="temperature", col=oceColorsJet)
mtext(l[["time"]])
if (!interactive()) dev.off()
