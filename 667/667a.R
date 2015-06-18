library(oce)

## pull out the Gulf stream
data(section)
GS <- subset(section, 109<=stationId&stationId<=129)

## make up some abundance data
x <- c(50, 130, 200, 200, 200, 300) # x location of sample
w <- c(10, 5, 30, 2, 10, 50) # width in km
a <- abs(rnorm(x)) # abundance value
z <- c(2, 2, 1, 2, 3, 3) # code the height of the sample

## this is crude, but here z codes the depth range, e.g.:
## 1. 0-500
## 2. 500-1000
## 3. 1500-2000

## Now make a function that will draw boxes to represent abundance
plotAbundance <- function(x, w, a, z, col) {

    for (i in seq_along(x)) {

        ## elseif to do a lookup for the depth ranges -- crude
        if (z[i] == 1) {
            zlim <- c(0, 500)
        } else if (z[i] == 2) {
            zlim <- c(500, 1000)
        } else if (z[i] == 3) {
            zlim <- c(1500, 2000)
        }

        ## setup the polygon and draw it
        xx <- c(x[i]-w[i]/2, x[i]+w[i]/2, x[i]+w[i]/2, x[i]-w[i]/2)
        zz <- c(zlim[1], zlim[1], zlim[2], zlim[2])
        polygon(xx, zz, col=col[i])
    }
}

if (!interactive()) png('667a.png')

cm <- colormap(a, breaks=length(x))
drawPalette(colormap=cm)
plot(GS, which='sigmaTheta', mar=c(3, 3, 1, 4))
plotAbundance(x, w, a, z, col=cm$zcol)

if (!interactive()) dev.off()
