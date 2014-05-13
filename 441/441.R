library(oce)
##source('~/src/oce/R/colors.R')
set.seed(441)
z <- rnorm(20)

## Part 1: test zlim in various conditions.  See the docs for
## those conditions, which are labourious to state here, and there
## is no point because all that matters is the docs and whether
## they are obeyed, and the tests below are intended to do the
## latter.
ZLIM <- range(z)
message("ZLIM: ", paste(range(z), collapse=" to "))
cm1 <- colormap(z=z)
stopifnot(all.equal(cm1$zlim, ZLIM))
cm2 <- colormap(z=z, breaks=seq(0, 3, 0.1))
stopifnot(all.equal(cm2$zlim, c(0, 3)))
cm3 <- colormap(z=z, zlim=c(-5, 5), breaks=seq(0, 3, 0.1))
stopifnot(all.equal(cm3$zlim, c(-5, 5)))
cm4 <- colormap(z=z, name="gmt_globe")
stopifnot(all.equal(cm4$zlim, c(-10000, 10000)))

## Below should rais an error, and it does, so no need to interrupt the flow
## here with an error!
##try(str(colormap(zclip=TRUE)))

## Part 2: test whether clipping is obeyed



