library(oce)
data(section)
ctd <- section[["station", 1]]

if (!interactive()) png("981.png")

par(mfrow=c(2,1))
plotProfile(ctd, xtype="nitrite")
mtext("Expect unit [umol/kg]", side=3, line=2, adj=1, col='magenta', font=2)

ctd[["metadata"]]$units$nitrite <- list(unit=expression(nmol/g), scale="")
plotProfile(ctd, xtype="nitrite")
mtext("Expect unit [nmol/g]", side=3, line=2, adj=1, col='magenta', font=2)

if (!interactive()) dev.off()
