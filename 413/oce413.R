#quartz(pointsize=8, width=5, height=5)
skipOce <- TRUE
if (!interactive()) png("oce413,png", width=5, height=5, unit="in", res=150, pointsize=9)
library(oce)
source('~/src/oce/R/imagep.R')
d <- 0.14
par(c('mai','pin','fin')) # before layout
layout(matrix(1:4,nrow=2,byrow=TRUE), widths=c(1-d,d))
omai <- par('mai')
par(c('mai','pin','fin')) # after layout

image(volcano, col=oceColorsJet(100), zlim=c(90, 200))
par(c('mai','pin','fin')) # after image 1
if (skipOce) {
    omai <- par('mai')
    par(mai=c(omai[1], 0, omai[3], 0.1))
    plot(1:3, 1:3, axes=FALSE, xlab="", ylab="")
    box()
    axis(4)
} else {
    drawPalette(c(90, 200), fullpage=TRUE, col=oceColorsJet, debug=4)
}
##par(mai=omai)
par(c('mai','pin','fin')) # after palette 1 

image(volcano, col=oceColorsJet(100), zlim=c(90, 200))
par(c('mai','pin','fin')) # after image 2
if (skipOce) {
    #omai <- par('mai')
    par(mai=c(omai[1], 0, omai[3], 0.1))
    plot(1:3, 1:3, axes=FALSE, xlab="", ylab="")
    box()
    axis(4)
} else {
    drawPalette(c(90, 200), fullpage=TRUE, col=oceColorsJet, debug=4)
}
##par(mai=omai)
par(c('mai','pin','fin')) # after palette 2 

if (!interactive()) dev.off()

