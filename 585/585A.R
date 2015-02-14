library(oce)
# source("~/src/oce/R/imagep.R")
# source("~/src/oce/R/adp.R")
data(adp)
if (!interactive()) png("585A.png", pointsize=11)
par(mfrow=c(2,2))

plot(adp, which=1, breaks=seq(-1, 1, 0.5), drawTimeRange=FALSE)
mtext('EXPECT: 3 color levels between -1 and 1', col='magenta', font=2, cex=2/3)
plot(adp, which=1, breaks=seq(-1, 1, 0.5), drawTimeRange=FALSE, col=oceColorsJet)
mtext('EXPECT: 3 jet color levels between -1 and 1', col='magenta', font=2, cex=2/3)

plot(adp, which=1, zlim=c(-1,1), drawTimeRange=FALSE)
mtext('EXPECT: many colors between -1 and 1', col='magenta', font=2, cex=2/3)
plot(adp, which=1, zlim=c(-1,1), drawTimeRange=FALSE, col=oceColorsJet)
mtext('EXPECT: many jet colors between -1 and 1', col='magenta', font=2, cex=2/3)

if (!interactive()) dev.off()
