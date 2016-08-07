library(oce)
if (!interactive()) png("1046a.png")
imagep(volcano)
x <- seq(0, 20, 0.5)
y <- seq(0, 20, 0.5)
z <- outer(x, y, function(x,y) cos(2*pi*x/20) * sin(2*pi*y/20))
imagep(40+x, 20+y, z, breaks=seq(-1,1,0.01), col=oceColorsJet, add=TRUE)
abline(v=40) # check that it's in right place
abline(h=20)
if (!interactive()) dev.off()

