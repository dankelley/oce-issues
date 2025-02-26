if (!interactive()) png("413A.png", width=5, height=5, unit="in", res=150, pointsize=9)
library(oce)
d <- 0.14
par(c('mai','pin','fin')) # before layout
layout(matrix(1:4,nrow=2,byrow=TRUE), widths=c(1-d,d))
par(c('mai','pin','fin')) # after layout
omai <- par('mai')

image(volcano, col=oceColorsJet(100), zlim=c(90, 200))
par(c('mai','pin','fin')) # after image 1
par(mai=c(omai[1], 0, omai[3], 0.3))
plot(1:3, 1:3, axes=FALSE, xlab="", ylab="")
box()
axis(4)
par(c('mai','pin','fin')) # after palette 1 

par(mai=omai) # NOTE: must reset or second image is bad
image(volcano, col=oceColorsJet(100), zlim=c(90, 200))
par(c('mai','pin','fin')) # after image 2
par(mai=c(omai[1], 0, omai[3], 0.3))
plot(1:3, 1:3, axes=FALSE, xlab="", ylab="")
box()
axis(4)
##par(mai=omai)
par(c('mai','pin','fin')) # after palette 2 

if (!interactive()) dev.off()

