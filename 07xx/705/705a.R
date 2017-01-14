library(oce)
library(testthat)
data(ctd)
expect_equal(ctd@metadata$waterDepth, NA)
data(ctdRaw)
expect_equal(ctdRaw@metadata$waterDepth, NA)
ctd <- read.ctd(system.file("extdata", "ctd.cnv", package="oce"))
expect_equal(ctd@metadata$waterDepth, NA)

