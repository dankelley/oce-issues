rm(list=ls())
library(oce)

load('data.rda')

if (!interactive()) png('414.png')
par(mfrow=c(2,1))

imagep(Tg$zg, filledContour = FALSE)

#imagep(Tg$zg, filledContour = TRUE)
imagep(Tg$zg+30, filledContour = TRUE, debug=0)
