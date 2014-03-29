rm(list=ls())
library(oce)

d <- 0.3

if (!interactive()) png('416A.png')
layout(matrix(c(1, 2), nrow=1), widths=c(1-d, d))

## first panel
imagep(volcano, drawPalette=TRUE)

## second panel
imagep(volcano, drawPalette=FALSE) # fails because of "margins too
                                   # large" error if
                                   # `drawPalette=TRUE`, presumably
                                   # because 0.3 is just not wide
                                   # enough for a proper imagep plot

if (!interactive()) dev.off()
