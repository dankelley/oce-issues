library(oce)
data(ctd)
if (!interactive()) png("1155a.png", pointsize=9)
par(mfrow=c(2, 1))
## Centre at the head of Bedford Basin
clon <- -63.662
clat <- 44.71711
plot(ctd, which="map", clatitude=clat, clongitude=clon)
abline(h=clat)
abline(v=clon)
mtext("EXPECT: map centred where lines cross", col="magenta", font=2, adj=1)

plot(ctd, which="map")
mtext("EXPECT: map centred at station (red dot)", col="magenta", font=2, adj=1)

if (!interactive()) dev.off()
