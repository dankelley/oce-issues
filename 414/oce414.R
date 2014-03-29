rm(list=ls())
library(oce)
source('~/src/oce/R/imagep.R')

load('data.rda')

if (!interactive()) png('issue414.png')
par(mfrow=c(2,1))

imagep(Tg$zg, filledContour = FALSE)

#imagep(Tg$zg, filledContour = TRUE)
imagep(Tg$zg+30, filledContour = TRUE, debug=0)
