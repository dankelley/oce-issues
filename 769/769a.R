library(oce)
source("~/src/oce/R/odf.R")
## system.time(d <- read.odf("../768/MCM_HUD2013021_1841_3508_300.ODF")) user 10.059s (home machine)
d <- read.odf("../768/MCM_HUD2013021_1841_3508_300.ODF", debug=100) # if > 99, we get timing info

## 10s orig
## 1.8s  if only read 1000 lines
## 1.26s with stringsAsFactors=FALSE
