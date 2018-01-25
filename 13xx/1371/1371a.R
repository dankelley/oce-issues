library(oce)
if (file.exists("~/git/oce/R/ctd.R"))
    source("~/git/oce/R/ctd.R")
options(digits=10)

## Tests start with those provided by issue 1371 reporter, but shortened for
## speed, and the 'oxygen' and 'fake' fields are set up as trends to reveal
## more clearly whether x autoscales well, if y is narrowed.

data(ctd)
ctd <- subset(ctd, pressure < 20)
p <- ctd[["pressure"]]
ctd <- oceSetData(ctd, 'oxygen', p, unit ='none')
ctd <- oceSetData(ctd, 'fake', -p, unit ='none')

plim <- c(100, 0)
xlim <- c(-15, -10)

if (!interactive()) png("1371a_%02d.png")

plotProfile(ctd, xtype='fake')
mtext(side=1, text="Test 1", line=0, col='magenta')
expect_equal(par("usr"), c(-20.51304, -0.74796, 20.51304, 0.74796))

plotProfile(ctd, xtype='fake', ylim=plim)
mtext(side=1, text="Test 2", line=0, col='magenta')
expect_equal(par("usr"), c(-20.51304, -0.74796, 104,-4))

plotProfile(ctd, xtype='fake', xlim=xlim)
mtext(side=1, text="Test 3", line=0, col='magenta')
expect_equal(par("usr"), c(-15.20000, -9.80000, 20.51304, 0.74796))

plotProfile(ctd, xtype='fake', plim=plim, xlim=xlim)
mtext(side=1, text="Test 4", line=0, col='magenta')
expect_equal(par("usr"), c(-15.2, -9.8, 104, -4.0))

plotProfile(ctd, xtype='fake', ylim=plim, xlim=xlim)
mtext(side=1, text="Test 5", line=0, col='magenta')
expect_equal(par("usr"), c(-15.2, -9.8, 104, -4))

plotProfile(ctd, xtype='oxygen')
mtext(side=1, text="Test 6", line=0, col='magenta')
expect_equal(par("usr"), c(0.74796, 20.51304, 20.51304, 0.74796))

plotProfile(ctd, xtype='oxygen', plim=plim)
mtext(side=1, text="Test 7", line=0, col='magenta')
expect_equal(par("usr"), c(0.74796, 20.51304, 104, -4))

plotProfile(ctd, xtype='oxygen', ylim=plim)
mtext(side=1, text="Test 8", line=0, col='magenta')
expect_equal(par("usr"), c(0.74796, 20.51304, 104, -4))

plotProfile(ctd, xtype='oxygen', xlim=-rev(xlim))
mtext(side=1, text="Test 9", line=0, col='magenta')
expect_equal(par("usr"), c(9.8, 15.2, 20.51304, 0.74796))

plotProfile(ctd, xtype='oxygen', plim=plim, xlim=-rev(xlim))
mtext(side=1, text="Test 10", line=0, col='magenta')
expect_equal(par("usr"), c(9.8, 15.2, 104, -4))

plotProfile(ctd, xtype='oxygen', ylim=plim, xlim=-rev(xlim))
mtext(side=1, text="Test 11", line=0, col='magenta')
expect_equal(par("usr"), c(9.8, 15.2, 104, -4))

## Salinity has Slim. See how this interacts with xlim.
plotProfile(ctd, xtype='salinity', ylim=plim)
mtext(side=1, text="Test 12", line=0, col='magenta')
expect_equal(par("usr"), c(29.99855641, 31.61705416, 104, -4))

t <- "Test 13: does providing both Slim and ylim work?"
plotProfile(ctd, xtype='salinity', ylim=plim, Slim=c(30, 31.0))
mtext(side=1, text=t, line=0, col='magenta')
expect_equal(par("usr"), c(29.96, 31.04, 104, -4), info=t)

t <- "Test 14: does providing both xlim and ylim work?"
plotProfile(ctd, xtype='salinity', ylim=plim, xlim=c(30, 31.0))
mtext(side=1, text=t, line=0, col='magenta')
expect_equal(par("usr"), c(29.99855641, 31.61705416, 104, -4), info=t)

t <- "Test 15: does S range narrow when p range is narrowed?"
plotProfile(ctd, xtype='salinity', plim=c(8,6))
mtext(side=1, text=t, line=0, col='magenta')
expect_equal(par("usr"), c(30.88451211, 31.15545961, 8.08000000, 5.92000000), info=t)

t <- "Test 16: does fake range narrow when p range is narrowed?"
plotProfile(ctd, xtype='fake', plim=c(8,6))
mtext(side=1, text=t, line=0, col='magenta')
expect_equal(par("usr"), c(-8.86696, -5.00704, 8.08, 5.92), info=t)

message("FIXME: check that narrowing the y limit (or plim etc) also narrows the
        range on the x axis, as appropriate.")

if (!interactive()) dev.off()

