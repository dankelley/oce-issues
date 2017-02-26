library(oce)
## Winter-time Nova Scotia and surrounding seas
ns <- read.landsat("/data/archive/landsat/LC80080292014065LGN00", band="tirs1")
tirs1 <- ns[["tirs1"]]
ML <- ns@metadata$header$radiance_mult_band_10
AL <- ns@metadata$header$radiance_add_band_10
K1 <- ns@metadata$header$k1_constant_band_10
K2 <- ns@metadata$header$k2_constant_band_10
Llambda <- ML * tirs1 + AL
d <- K2 / log(K1 / Llambda + 1)
temperature <- d - 273.15
temperature[tirs1 == 0] <- NA
ns <- landsatAdd(ns, temperature, "temperature")
ns2 <- decimate(ns, by=10)
if (!interactive()) png("486B.png", width=7, height=7, unit="in", res=100)
plot(ns, band="temperature", col=oceColorsJet)
title(ns[['time']])
if (!interactive()) dev.off()

