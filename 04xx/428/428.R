if (!interactive()) pdf("428.pdf")

library(oce)

x <- seq(0, 2, length.out=20)
y <- sin(pi * x)

par(mfcol=c(3,2), mar=c(2, 2, 1, 1), mgp=c(2,0.7,0))
plot(x, y)
errorbars(x, y, xe=0, ye=0.2, style=0)
mtext("(y0) ", side=3, line=-1.3, adj=1)
plot(x, y)
errorbars(x, y, xe=0.2, ye=0, style=0)
mtext("(x0) ", side=3, line=-1.3, adj=1)
plot(x, y)
errorbars(x, y, xe=0.2, ye=0.2, style=0)
mtext("(xy0) ", side=3, line=-1.3, adj=1)

plot(x, y)
errorbars(x, y, xe=0, ye=0.2, style=1)
mtext("(y1) ", side=3, line=-1.3, adj=1)
plot(x, y)
errorbars(x, y, xe=0.2, ye=0, style=1)
mtext("(x1) ", side=3, line=-1.3, adj=1)
plot(x, y)
errorbars(x, y, xe=0.2, ye=0.2, style=1)
mtext("(xy1) ", side=3, line=-1.3, adj=1)

if (!interactive()) dev.off()
