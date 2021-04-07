library(oce)
source("~/git/oce/R/colors.R")
z <- seq(-3,3,length.out=11)
cmz <- colormap(z=z)
expect_equal(cmz$zlim, rangeExtended(z))
expect_equal(cmz$zclip, FALSE)
expect_equal(cmz$missingColor, "gray")

zlim <- c(-10, 10)
cmzlim <- colormap(zlim=zlim)
expect_equal(cmzlim$zlim, zlim)
expect_equal(cmzlim$zclip, FALSE)
expect_equal(cmzlim$missingColor, "gray")

