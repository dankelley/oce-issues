library(oce)
debug <- 0
d <- read.ctd.saiv("Tr1_St2_Graveneset.txt", debug=debug)
# ensure that original name worked correctly
stopifnot(identical(d[["fluorescence"]], d[["F (µg/l)"]]))
summary(d)
