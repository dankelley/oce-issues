# vim: tw=140

library(oce)
options(width=200)

diml <- read.oce("CTD_1994038_147_1_DN.ODF")
summary(diml)

dbio <- read.oce("CTD_BCD2014666_008_1_DN.ODF")
summary(dbio)
