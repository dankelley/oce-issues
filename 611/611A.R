library(oce)
library(marmap)

## message("really, as.topo should do this...")
## as.topo <- function(longitude, latitude, z, filename="")
## {
##     if (inherits(longitude, "bathy")) {
##         b <- longitude
##         longitude <- as.numeric(rownames(b))
##         latitude <- as.numeric(colnames(b))
##         z <- as.matrix(a)
##     }
##     ncols <- length(longitude)
##     nrows <- length(latitude)
##     longitudeLowerLeft <- min(longitude, na.rm=TRUE)
##     latitudeLowerLeft <- min(latitude, na.rm=TRUE)
##     dim <- dim(z)
##     if (dim[1] != ncols)
##         stop("longitude vector has length ", ncols, ", which does not match matrix width ", dim[1])
##     if (dim[2] != nrows)
##         stop("latitude vector has length ", ncols, ", which does not match matrix height ", dim[2])
##     rval <- new("topo", latitude=latitude, longitude=longitude, z=z, filename=filename)
##     rval@processingLog <- processingLog(rval@processingLog,
##                                         paste(deparse(match.call()), sep="", collapse=""))
##     rval
## }

a <- getNOAA.bathy(-65, -60, 40, 45)
t <- as.topo(a)
if (!interactive()) png("611A.png")
plot(t)
if (!interactive()) dev.off()


