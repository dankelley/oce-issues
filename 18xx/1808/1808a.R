# vim: tw=140

library(oce)
options(width=200)

source("~/git/oce/R/misc.R")
source("~/git/oce/R/odf.R")
source("~/git/oce/R/oce.R")

diml <- read.oce("CTD_1994038_147_1_DN.ODF")
summary(diml)

dbio <- read.oce("CTD_BCD2014666_008_1_DN.ODF")
summary(dbio)

dunb <- read.oce("CTD_2020003_004_1_DN.odf")
summary(dunb)

