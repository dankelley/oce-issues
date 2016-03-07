library(oce)
try(source("~/src/oce/R/adv.nortek.R"))
d <- read.adv.nortek("~/Dropbox/OCE-ADV-IMU-Mr2/15080902.vec", from=1, to=100)
names(d@data)
