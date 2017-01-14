library(oce)
x <- -10:10
y <- -30:30
z <- matrix(seq(-100, 0, length.out=length(x)*length(y)), nrow=length(x))
par(mfrow=c(1,2))
imagep(x, y, z, col=oceColorsJet, asp=1)
imagep(x, y, z, col=oceColorsJet, asp=1, filledContour=TRUE)

