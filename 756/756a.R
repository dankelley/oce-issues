library(ODF)
library(oce)
d <- read_odf("CTD_HUD2014030_163_1_DN.ODF")
print(names(d$DATA))
