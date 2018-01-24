library(oce)
data(ctd)
set.seed(1371) # for reproducibility
ctd <- oceSetData(ctd, 'oxygen', rnorm(ctd[['pressure']]), unit ='none')
ctd <- oceSetData(ctd, 'stupid', rnorm(ctd[['pressure']]), unit ='none')

plim <- c(100,0)
xlim <- c(0,3)
if (!interactive()) png("1371a_%02d.png")

plotProfile(ctd, xtype = 'stupid')
mtext(side = 1, text = 'EXPECT: 0<p<46; -2.9<x<3.4 {OK}', line = 0, col='magenta')

plotProfile(ctd, xtype = 'stupid', plim = plim)
mtext(side = 1, text = 'EXPECT: 0<p<46; -2.9<x<3.4 {FAIL}', line = 0, col='magenta')

plotProfile(ctd, xtype = 'stupid', ylim = plim)
mtext(side = 1, text = 'ylim', line = 1)

plotProfile(ctd, xtype = 'stupid', xlim = xlim)
mtext(side = 1, text = 'xlim', line = 1)

plotProfile(ctd, xtype = 'stupid', plim = plim, xlim = xlim)
mtext(side = 1, text = 'plim + xlim', line = 1)
plotProfile(ctd, xtype = 'stupid', ylim = plim, xlim = xlim)
mtext(side = 1, text = 'ylim + xlim', line = 1)

plotProfile(ctd, xtype = 'oxygen')

plotProfile(ctd, xtype = 'oxygen', plim = plim)
plotProfile(ctd, xtype = 'oxygen', ylim = plim)

plotProfile(ctd, xtype = 'oxygen', xlim = xlim)

plotProfile(ctd, xtype = 'oxygen', plim = plim, xlim = xlim)
##plotProfile(ctd, xtype = 'oxygen', ylim = plim, xlim = xlim, debug=3) # dies

if (!interactive()) dev.off()

