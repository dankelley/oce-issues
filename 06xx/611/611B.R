library(marmap)
library(oce)
a <- getNOAA.bathy(-120, 0, 0, 80, resolution=2*60)
t <- as.topo(a)
if (!interactive()) png("611B.png")
par(mfrow=c(2, 1))
plot(t, xlim=c(-120, 0), location="left")
mapPlot(range(t[['longitude']]), range(t[['latitude']]),
        proj="+proj=lcc +lon_0=-60 +lat_0=20 +lat_1=20", type='n')
mapImage(t)
if (!interactive()) dev.off()

