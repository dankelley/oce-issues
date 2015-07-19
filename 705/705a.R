library(oce)
library(testthat)
try(source("~/src/oce/R/ctd.R"))
ctd <- read.ctd(system.file("extdata", "ctd.cnv", package="oce"))
expect_equal(ctd@metadata$waterDepth, NA)

