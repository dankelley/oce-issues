library(oce)
##try(source("~/src/oce/R/ctd.itp.R"))
##try(source("~/src/oce/R/oce.R"))
ctd <- read.oce("~/Dropbox/oce-working-notes/ctd/itp/itp59grd0002.dat")
summary(ctd)
if (!interactive()) png("1029a.png")
plot(ctd)
if (!interactive()) dev.off()

