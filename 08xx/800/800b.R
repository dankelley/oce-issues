rm(list=ls())
library(oce)

data(ctd)

if (!interactive()) pdf('800b.pdf')

plotProfile(ctd, lty=2)

plotProfile(ctd, xtype="salinity", lty=2)
plotProfile(ctd, xtype="conductivity", lty=2)
plotProfile(ctd, xtype="temperature", lty=2)
plotProfile(ctd, xtype="theta", lty=2)
plotProfile(ctd, xtype="density", lty=2)
plotProfile(ctd, xtype="index", lty=2)
plotProfile(ctd, xtype="salinity+temperature", lty=2)
plotProfile(ctd, xtype="N2", lty=2)
plotProfile(ctd, xtype="density+N2", lty=2)
plotProfile(ctd, xtype="density+dpdt", lty=2)
plotProfile(ctd, xtype="spice", lty=2)
plotProfile(ctd, xtype="Rrho", lty=2)
plotProfile(ctd, xtype="RrhoSF", lty=2)

if (!interactive()) dev.off()

