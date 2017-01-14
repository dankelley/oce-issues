library(oce)
##try(source("~/src/oce/R/ctd.R"))
data(ctd)
if (!interactive()) png("870a.png")
plotProfile(ctd, xtype='density+dpdt')
if (!interactive()) dev.off()

