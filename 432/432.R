if (!interactive()) png("432.png", width=7, height=7, unit="in", res=150, pointsize=12)
library(maptools)
library(oce)
data(ctd)
ctd[["temperature"]]
if (!interactive()) dev.off()
