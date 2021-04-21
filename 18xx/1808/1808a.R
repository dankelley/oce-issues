library(oce)
#source("~/git/oce/R/odf.R")
#source("~/git/oce/R/oce.R")
#source("~/git/oce/R/ctd.R")
#source("~/git/oce/R/ctd.odf.R")
#source("~/git/oce/R/misc.R")

debug <- 0 # set to 3 to get debugging
diml <- read.oce("CTD_1994038_147_1_DN.ODF", debug=debug)
summary(diml)

dbio <- read.oce("CTD_BCD2014666_008_1_DN.ODF", debug=debug)
summary(dbio)
