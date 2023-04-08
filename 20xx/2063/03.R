library(oce)
f <- "R6990512_001.nc"
a <- read.oce(f)
ctd <- as.ctd(a, debug=2)
