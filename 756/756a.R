library(ODF)                           # DK version, patched to work in his locale
library(oce)
try(source("~/src/oce/R/oce.R"))
try(source("~/src/oce/R/odf.R"))
d <- read_odf("CTD_HUD2014030_163_1_DN.ODF")
dd <- as.oce(d)
summary(dd)
