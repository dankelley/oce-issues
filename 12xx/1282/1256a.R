library(oce)
data(coastlineWorld)

if (!interactive()) png("1256a_%d.png")

par(mfrow=c(2,2))
plot(coastlineWorld, clongitude=-63.5, clatitude=46, span=1000)
mtext("expect: polygon", col="magenta", side=3, adj=1, line=0)

plot(coastlineWorld, clongitude=-63.5, clatitude=46, span=1000, type="l", col="red")
mtext("expect: red lines", col="magenta", side=3, adj=1, line=0)

plot(coastlineWorld, clongitude=-63.5, clatitude=46, span=1000, type="p", col="red", pch=2)
mtext("expect: red triangles", col="magenta", side=3, adj=1, line=0)

plot(coastlineWorld, clongitude=-63.5, clatitude=46, span=1000, type="o", col="red",pch=20)
mtext("expect: red lines and pch=20 points", col="magenta", side=3, adj=1, line=0)

if (!interactive()) dev.off()

