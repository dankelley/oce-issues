library(oce)
data(section)
ctd <- section[["station", 1]]

if (!interactive()) png("981a.png")

N <- 4
par(mfrow=c(N,4))

unitFake <- list(unit=expression(m/s^2), scale="fake")

plotProfile(ctd, xtype="temperature")
ctd[["metadata"]]$units$temperature <- unitFake
plotProfile(ctd, xtype="temperature")
mtext("Expect m/s^2 ", side=3, line=-1, adj=1, col='magenta', font=2, cex=2/3)

plotProfile(ctd, xtype="salinity")
ctd[["metadata"]]$units$salinity <- unitFake
plotProfile(ctd, xtype="salinity")
mtext("Expect m/s^2 ", side=3, line=-1, adj=1, col='magenta', font=2, cex=2/3)

plotProfile(ctd, xtype="nitrite")
ctd[["metadata"]]$units$nitrite <- unitFake
plotProfile(ctd, xtype="nitrite")
mtext("Expect m/s^2 ", side=3, line=-1, adj=1, col='magenta', font=2, cex=2/3)

plotProfile(ctd, xtype="oxygen")
ctd[["oxygenUnit"]] <- unitFake
plotProfile(ctd, xtype="oxygen")
mtext("Expect m/s^2 ", side=3, line=-1, adj=1, col='magenta', font=2, cex=2/3)

plotProfile(ctd, xtype="phosphate")
ctd[["metadata"]]$units$phosphate <- unitFake
plotProfile(ctd, xtype="phosphate")
mtext("Expect m/s^2 ", side=3, line=-1, adj=1, col='magenta', font=2, cex=2/3)

plotProfile(ctd, xtype="silicate")
ctd[["metadata"]]$units$silicate <- unitFake
plotProfile(ctd, xtype="silicate")
mtext("Expect m/s^2 ", side=3, line=-1, adj=1, col='magenta', font=2, cex=2/3)

plotProfile(ctd, xtype="NO2+NO3")
ctd[["NO2+NO3Unit"]] <- unitFake
plotProfile(ctd, xtype="NO2+NO3")
mtext("Expect m/s^2 ", side=3, line=-1, adj=1, col='magenta', font=2, cex=2/3)

ctd <- ctdAddColumn(ctd, ctd[["SP"]]/2, "S2", unit=list(unit=expression(PSU/2), scale="fake"))
plotProfile(ctd, xtype="S2")
ctd[["S2Unit"]] <- unitFake
plotProfile(ctd, xtype="S2")
mtext("Expect m/s^2 ", side=3, line=-1, adj=1, col='magenta', font=2, cex=2/3)

if (!interactive()) dev.off()
