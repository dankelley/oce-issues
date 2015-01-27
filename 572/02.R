library(oce)
l <- read.landsat("~/Downloads/LC80400352014241LGN00", band="tirs1")
plot(l, band="temperature")
