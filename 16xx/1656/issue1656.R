## Show that plot()'s TS plots obey col, pch, and cex.
library(oce)
load("testCTD.RData")
cm <- colormap(haul05.trim[["pressure"]])
if (!interactive()) png("issue1657.png")
par(mfrow=c(2, 2))
plot(haul05.trim, which=3)
plot(haul05.trim, which=3, col=cm$zcol, pch=20, cex=2)
plotProfile(haul05.trim, xtype="fluorescence", type="p")
plot(haul05.trim, which="fluorescence", type="p", col=cm$zcol, pch=20, cex=2)
if (!interactive()) dev.off()

