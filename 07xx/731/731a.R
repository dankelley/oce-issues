library(oce)
library(testthat)
try(source("~/src/oce/R/ctd.R"))

data(ctd)

ctd2 <- ctd
ctd2@data$conductivity <- swCSTp(ctd2)*42.914
ctd2[['conductivityUnit']] <- 'mS/cm'
expect_equal(swSCTp(ctd2), ctd2[['salinity']], scale=1, tolerance=1e-8) # OK on 64-bit OSX

ctd3 <- ctd
ctd3@data$conductivity <- swCSTp(ctd3)*4.2914
ctd3[['conductivityUnit']] <- 'S/m'
expect_equal(swSCTp(ctd3), ctd3[['salinity']], scale=1, tolerance=1e-8) # OK on 64-bit OSX

if (!interactive()) png("731a.png")
par(mfrow=c(3,1))
plotProfile(ctd, xtype="conductivity")
mtext(" EXPECT: [unitless]", col=6, font=2, adj=0, line=-1.5)
mtext("(a) ", font=2, col=6, adj=1, line=-1.5)
plotProfile(ctd2, xtype="conductivity")
mtext(" EXPECT: [mS/cm]", col=6, font=2, adj=0, line=-1.5)
mtext("(b) ", font=2, col=6, adj=1, line=-1.5)
plotProfile(ctd3, xtype="conductivity")
mtext(" EXPECT: [S/m]", col=6, font=2, adj=0, line=-1.5)
mtext("(c) ", font=2, col=6, adj=1, line=-1.5)

if (!interactive()) dev.off()
