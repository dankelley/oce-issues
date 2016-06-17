library(oce)
try(source("~/src/oce/R/ctd.R"))
data(ctd)
## make up a fake oxygen field
ctd <- oceSetData(ctd, 'oxygen', ctd[['temperature']]/2)
plim <- c(40, 0)
if (!interactive()) png("989a.png")
par(mfrow=c(1, 2))
plotProfile(ctd, xtype='temperature', plim=plim)
plotProfile(ctd, xtype='oxygen', plim=plim)
if (!interactive()) dev.off()

