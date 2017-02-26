library(oce)
data(adp)
if (!interactive()) png("585A_%d.png", pointsize=11)
par(mfrow=c(3,1))

cm <- colormap(z=adp[["v"]])

plot(adp, which=1, breaks=seq(-1, 1, 0.5), drawTimeRange=FALSE)
mtext('EXPECT: 4 color levels between -1 and 1', col='magenta', font=2)

plot(adp, which=1, zlim=c(-1, 1), drawTimeRange=FALSE)
mtext('EXPECT: many color levels between -1 and 1', col='magenta', font=2)

plot(adp, which=1, colormap=cm, drawTimeRange=FALSE)
mtext('EXPECT: many jet color levels between -1 and 1', col='magenta', font=2)

if (!interactive()) dev.off()
