library(oce)
d <- read.oce("example_ct1.csv")
if (!"flags" %in% names(d@metadata))
    stop("should be storing 'flags' into the metadata' slot")

