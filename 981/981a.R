library(oce)
data(section)
ctd <- section[["station", 1]]

if (!interactive()) png("981.png")

plotProfile(ctd, xtype="nitrite")
mtext("Expect unit [umol/kg]", side=3, line=2, adj=1, col='magenta', font=2)

if (!interactive()) dev.off()
