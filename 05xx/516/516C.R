rm(list=ls())
#do <- c("b", "d") # easier to read output during debugging
do <- c("a", "b", "c", "d") # easier to read output during debugging
if (!interactive()) png("516C.png", width=700, height=400, pointsize=11, type="cairo", antialias="none")
library(oce)

data(coastlineWorld)
data(topoWorld)
if (2 < length(do)) par(mfrow=c(2,2), mar=c(1, 1, 2, 1)) else par(mfrow=c(2,1), mar=c(1, 1, 2, 1))

if ("a" %in% do) {
    mapPlot(coastlineWorld)
    mapImage(topoWorld, breaks=seq(-2000, 2000, 500), debug=3)
    mtext(paste('EXPECT: as (c) but projected'), col=6, font=2)
    mtext('(a)', line=0.2, adj=1)
}
if ("b" %in% do) {
    mapPlot(coastlineWorld)
    mapImage(topoWorld, zlim=c(-2000, 2000), debug=3)
    mtext(paste('EXPECT: as (d) but projected'), col=6, font=2)
    mtext('(b)', line=0.2, adj=1)
}
if ("c" %in% do) {
    imagep(topoWorld, breaks=seq(-2000, 2000, 500), debug=3)
    mtext(paste('EXPECT: 500-m colour bands'), col=6, font=2)
    mtext('(c)', line=0.2, adj=1)
}
if ("d" %in% do) {
    imagep(topoWorld, zlim=c(-2000, 2000), debug=3)
    mtext(paste('EXPECT: blending colours'), col=6, font=2)
    mtext('(d)', line=0.2, adj=1)
}

if (!interactive()) dev.off()

