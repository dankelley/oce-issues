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
expect_equal(par("usr"), c(-2.941369677, 3.435422823, 45.847440000, -0.226440000))

plotProfile(ctd, xtype='stupid', plim=plim)
mtext(side=1, text='2) EXPECT: 0<p<100; -2.9<x<3.4 {OK}', line=0, col='magenta')
expect_equal(par("usr"), c(-2.941369677, 3.435422823, 104, -4))

plotProfile(ctd, xtype='stupid', ylim=plim)
mtext(side=1, text='3) EXPECT: 0<p<100; -2.9<x<3.4 {OK}', line=0, col='magenta')
expect_equal(par("usr"), c(-2.941369677, 3.435422823, 104, -4))

plotProfile(ctd, xtype='stupid', xlim=xlim)
mtext(side=1, text='4) EXPECT: 0<p<46; 0<x<3 {OK}', line=0, col='magenta')
expect_equal(par("usr"), c(-0.12, 3.12, 45.84744, -0.22644))

plotProfile(ctd, xtype='stupid', plim=plim, xlim=xlim)
mtext(side=1, text='5) EXPECT: 0<p<100; 0<x<3 {OK}', line=0, col='magenta')
expect_equal(par("usr"), c(-0.12, 3.12, 104, -4))

plotProfile(ctd, xtype='stupid', ylim=plim, xlim=xlim)
mtext(side=1, text='6) EXPECT: 0<p<100; 0<x<3 {OK}', line=0, col='magenta')
expect_equal(par("usr"), c(-0.12, 3.12, 104, -4))

plotProfile(ctd, xtype = 'oxygen')
mtext(side=1, text='7) EXPECT: 0<p<46; -2.9<x<3.4 {OK}', line=0, col='magenta')
expect_equal(par("usr"), c(-2.660770532, 2.221423523, 45.847440000, -0.226440000))


plotProfile(ctd, xtype = 'oxygen', plim = plim)
mtext(side=1, text='8) EXPECT: 0<p<100; -2.9<x<3.4 {FAIL}', line=0, col='magenta')
expect_equal(par("usr"), c(-2.660770532, 2.221423523, -4, 104))

plotProfile(ctd, xtype = 'oxygen', ylim = plim)
mtext(side=1, text='9) EXPECT: 0<p<100; -2.9<x<3.4 {OK}', line=0, col='magenta')
expect_equal(par("usr"), c(-2.660770532, 2.221423523, 104, -4))

plotProfile(ctd, xtype = 'oxygen', xlim = xlim)
mtext(side=1, text='10) EXPECT: 0<p<46; -2.9<x<3.4 {OK}', line=0, col='magenta')
expect_equal(par("usr"), c(-0.12, 3.12, 45.847440000, -0.226440000))

plotProfile(ctd, xtype = 'oxygen', plim = plim, xlim = xlim)
mtext(side=1, text='11) EXPECT: 0<p<100; 0<x<3 {FAIL}', line=0, col='magenta')
expect_equal(par("usr"), c(-0.12, 3.12, 104, -4))

##plotProfile(ctd, xtype = 'oxygen', ylim = plim, xlim = xlim, debug=3) # dies

if (!interactive()) dev.off()

