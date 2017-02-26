rm(list=ls())
library(oce)
data(landsat)

if (!interactive()) png('706a.png', width=1000, height=500) else dev.new(width=7, height=3.5)
par(mfrow=c(1,2))

## box <- locator(2)
box <- structure(list(x = c(-64.3529648838106, -63.745041343913), y = c(44.2401391667528, 
44.7570992655045)), .Names = c("x", "y"))

plot(landsat)
polygon(c(box$x[1], box$x[1], box$x[2], box$x[2]),
        c(box$y[1], box$y[2], box$y[2], box$y[1]),
        lwd=3)
xlim <- par('usr')[1:2]
ylim <- par('usr')[3:4]

lt <- landsatTrim(landsat, box=box)
plot(lt, xlim=xlim, ylim=ylim)
mtext('EXPECT: only data from within black box in panel 1', col='purple', line=-1, adj=0)

if (!interactive()) dev.off()
