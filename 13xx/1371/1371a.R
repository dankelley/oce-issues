library(oce)
if (file.exists("~/git/oce/R/ctd.R"))
    source("~/git/oce/R/ctd.R")
options(oceDebug=10) # turns on debugging for all oce code
data(ctd)
set.seed(1371) # for reproducibility
ctd <- oceSetData(ctd, 'oxygen', rnorm(ctd[['pressure']]), unit ='none')
ctd <- oceSetData(ctd, 'stupid', rnorm(ctd[['pressure']]), unit ='none')

plim <- c(100,0)
xlim <- c(0,3)
if (!interactive()) png("1371a_%02d.png")

plotProfile(ctd, xtype='stupid')
mtext(side=1, text='1) EXPECT: 0<p<46; -2.9<x<3.4 {OK}', line=0, col='magenta')

plotProfile(ctd, xtype='stupid', plim=plim)
mtext(side=1, text='2) EXPECT: 0<p<100; -2.9<x<3.4 {OK}', line=0, col='magenta')

plotProfile(ctd, xtype='stupid', ylim=plim)
mtext(side=1, text='3) EXPECT: 0<p<100; -2.9<x<3.4 {OK}', line=0, col='magenta')

plotProfile(ctd, xtype='stupid', xlim=xlim)
mtext(side=1, text='4) EXPECT: 0<p<46; 0<x<3 {OK}', line=0, col='magenta')

plotProfile(ctd, xtype='stupid', plim=plim, xlim=xlim)
mtext(side=1, text='5) EXPECT: 0<p<100; 0<x<3 {OK}', line=0, col='magenta')

plotProfile(ctd, xtype='stupid', ylim=plim, xlim=xlim)
mtext(side=1, text='6) EXPECT: 0<p<100; 0<x<3 {OK}', line=0, col='magenta')

plotProfile(ctd, xtype = 'oxygen')
mtext(side=1, text='7) EXPECT: 0<p<46; -2.9<x<3.4 {OK}', line=0, col='magenta')

plotProfile(ctd, xtype = 'oxygen', plim = plim)
mtext(side=1, text='8) EXPECT: 0<p<100; -2.9<x<3.4 {OK}', line=0, col='magenta')

plotProfile(ctd, xtype = 'oxygen', ylim = plim)
mtext(side=1, text='9) EXPECT: 0<p<100; -2.9<x<3.4 {OK}', line=0, col='magenta')

plotProfile(ctd, xtype = 'oxygen', xlim = xlim)
mtext(side=1, text='10) EXPECT: 0<p<46; -2.9<x<3.4 {OK}', line=0, col='magenta')

plotProfile(ctd, xtype = 'oxygen', plim = plim, xlim = xlim)
mtext(side=1, text='11) EXPECT: 0<p<100; 0<x<3 {FAIL}', line=0, col='magenta')

##plotProfile(ctd, xtype = 'oxygen', ylim = plim, xlim = xlim, debug=3) # dies

if (!interactive()) dev.off()

