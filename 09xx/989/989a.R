library(oce)
try(source("~/src/oce/R/ctd.R"))
data(ctd)
## make up a fake oxygen field
ctd <- oceSetData(ctd, "oxygen", ctd[['temperature']]/2,
                  unit=list(unit=expression(mu*mol/kg), scale=""))
ctd <- oceSetData(ctd, "fakeOxygen", ctd[['temperature']]/2,
                  unit=list(unit=expression(mu*mol/kg), scale=""))
plim <- c(40, 0)
if (!interactive()) png("989a.png")
par(mfrow=c(1, 3))
## Temperature is a special case, so do that, along with
## oxygen (a known variable, but not special case) and also
## a made-up variable. Thus, we exercise three sections
## of the plotProfile() code. This is not exhaustive, but
## it may be enough to close the issue (which of course can
## be reopened later).
plotProfile(ctd, xtype='temperature', plim=plim)
plotProfile(ctd, xtype='oxygen', plim=plim)
plotProfile(ctd, xtype='fakeOxygen', plim=plim)
if (!interactive()) dev.off()

