library(oce)
options(oceDebug = 4)
#setwd("~/Downloads")
l <- read.landsat("~/Downloads/LC80400352014241LGN00", band="tirs2")

ML <- l@metadata$header$radiance_mult_band_11
AL <- l@metadata$header$radiance_add_band_11
K1 <- l@metadata$header$k1_constant_band_11
K2 <- l@metadata$header$k2_constant_band_11

tirs2 <- l[["tirs2"]]
#image[["tirs2"]]

## CHANGE 1: no need to scale; see that by typing
##    range(tirs2)
## in the R console.
d <- if (FALSE) tirs2* (2^16-1) else tirs2 # convert from range 0 to 1


Llambda <- ML * d + AL
dd <- K2 / log(K1 / Llambda + 1)
SST <- dd - 273.15                 # convert Kelvin to Celcius
## CHANGE 2: you did not assign the result from landsatAdd()
## to anything.  Also, I removed the line after this.
l <- landsatAdd(l, SST, "SST")
#l@data$SST <- SST

## CHANGE 3: I controlled the temperature scale. NOTE: this seems
## very hot ... I don't imagine this is correct, and maybe
## it is a problem with the calibration, as was noted on the NASA
## site via a pop-up window.
plot(l, band="SST", col=oceColorsJet, zlim=c(10,50)) #oceColorsJet
