library(oce)
data(ctd)
if (!interactive()) png("1486a.png", height=300)
par(mfrow=c(1, 2), mar=c(3,3,1,1), mgp=c(2,0.7,0))
p <- ctd[["pressure"]]
spiciness0 <- gsw_spiciness0(ctd[["SA"]], ctd[["CT"]])
spice <- swSpice(ctd)
plot(spiciness0, p, type='l', xlim=c(-2.7,-1.4), ylim=c(50,0),
     xlab="spiciness0 & spice", ylab="pressure")
lines(spice, p, col=2)
cm <- colormap(z=p)
drawPalette(colormap=cm)
plot(spice, spiciness0, xlab="Flament spice", ylab="GSW spiciness0", col=cm$zcol, pch=20)
mtext("color indicates pressure", cex=0.8)

## Funnel-of-applicability check
range(ctd[["salinity"]])
range(ctd[["temperature"]])

if (!interactive()) dev.off()
