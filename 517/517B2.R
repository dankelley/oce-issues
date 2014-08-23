library(png)
i <- readPNG("517B.png")
ii <- i
i0 <- 280
j0 <- 500
if (FALSE) { # learn how to index
    par(mfrow=c(1,2), mar=rep(0.25,4))
    image(i[,,1], axes=FALSE)
    I <- rep(0:10, 5)
    J <- rep(0:10, each=5)
    ii[i0+I, j0+J,1]<-1
    image(ii[,,1], axes=FALSE)
    ## conclude: 280, 500 is in deep water
}
pixel <- i[i0, j0,]
stopifnot(all.equal(pixel, c(0.05882353, 0.48627451,0.67058824)))

