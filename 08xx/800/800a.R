rm(list=ls())
library(oce)
try(source('~/src/oce/R/ctd.R'))
try(source('~/src/R-richards/oce/R/ctd.R'))

data(ctd)

if (!interactive()) pdf('800a.pdf')

plotProfile(ctd)

plotProfile(ctd, xtype="salinity")
plotProfile(ctd, xtype="conductivity")
plotProfile(ctd, xtype="temperature")
plotProfile(ctd, xtype="theta")
plotProfile(ctd, xtype="density")
plotProfile(ctd, xtype="index")
plotProfile(ctd, xtype="salinity+temperature")
plotProfile(ctd, xtype="N2")
plotProfile(ctd, xtype="density+N2")
plotProfile(ctd, xtype="density+dpdt")
plotProfile(ctd, xtype="spice")
plotProfile(ctd, xtype="Rrho")
plotProfile(ctd, xtype="RrhoSF")

if (!interactive()) dev.off()

