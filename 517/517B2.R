pixel <- function(i, n) {
    ## Clark Richard's colourization method (used in oce landsat plotting)
    colors <- rgb(i[,,1], i[,,2], i[,,3], maxColorValue=1)
    col <- unique(colors)
    dim <- dim(i)[1:2]
    d <- array(match(colors, col), dim=dim)
    library(oce)
    imagep(z=d, col=col, drawPalette=FALSE, mar=c(3, 3, 2, 2), xlab="pixel i value", ylab="pixel j value")
    mtext(paste("Click ", n, "points in image"), col='red', font=2)
    xy <- locator(n)
    i <- as.integer(round(xy$x))
    j <- as.integer(round(xy$y))
    list(i=i, j=j)
}

library(png)
i <- readPNG("517B.png")
# pixel(i, 2)
deep1 <- list(i=260, j=600)
deep2 <- list(i=600, j=600)
stopifnot(all.equal(i[deep1$i, deep1$j,], c(0.05882353, 0.48627451,0.67058824)))
stopifnot(all.equal(i[deep2$i, deep2$j,], c(0.05882353, 0.48627451,0.67058824)))

