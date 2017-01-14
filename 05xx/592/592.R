## three pages: CR originally go that only first worked
library(oce)
## source("~/src/oce/R/landsat.R")
if (!interactive()) png("592_%d.png")

l <- read.landsat('LC80080292014065LGN00', band=8)
plot(l)

l <- read.landsat('LC80080292014065LGN00', band=c(8, 10))
plot(l, band="panchromatic") # failed for CR

l <- read.landsat('LC80080292014065LGN00', band=8)
plot(l, band='panchromatic') # failed for CR

if (!interactive()) dev.off()
