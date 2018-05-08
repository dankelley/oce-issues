library(oce)
data(ctd)
if (!interactive()) png("1403a.png")
par(mfrow=c(2, 4))
options(oceEOS="gsw")
plotProfile(ctd, xtype="temperature")
plotProfile(ctd, xtype="salinity")
plotProfile(ctd, xtype="sigmaTheta")
plotProfile(ctd, xtype="N2")

options(oceEOS="unesco")
plotProfile(ctd, xtype="temperature")
plotProfile(ctd, xtype="salinity")
plotProfile(ctd, xtype="sigmaTheta")
plotProfile(ctd, xtype="N2")

if (!interactive()) dev.off()

