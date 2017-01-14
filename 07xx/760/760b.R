library(oce)
library(testthat)
try(source("~/src/oce/R/oce.R"))
try(source("~/src/oce/R/ctd.R"))
## "/Library/Frameworks/R.framework/Versions/3.2/Resources/library/oce/extdata/d200321-001.ctd"
d <- read.ctd.woce(system.file("extdata", "d200321-001.ctd", package = "oce"))
expect_equal(sort(names(d@data)), c("fluorescence", "oxygen", "pressure", "salinity",
                                    "sigmaTheta", "temperature", "transmission"))

expect_equal(0, length(d@metadata$flags))
