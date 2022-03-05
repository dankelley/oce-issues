# Preparation for tests within oce tests/testthat/test_ctd.R
# Requires local sources *or* an up-to-date oce from "develop".
library(oce)
library(testthat)
if (file.exists("~/git/oce/R/ctd.aml.R")) {
    source("~/git/oce/R/ctd.aml.R")
    source("~/git/oce/R/oce.R")
}

file <- "Custom.export.026043_2021-07-21_17-36-45.txt"
expect_equal("aml/txt", oceMagic(file))
ctd <- read.oce(file)
expect_equal(head(ctd[["temperature"]], 3),
    c(5.867, 5.986, 6.058))
expect_equal(head(ctd[["salinity"]], 3),
    c(2.61918633678843, 5.27124897467692, 8.10531077140948))
expect_equal(head(ctd[["pressure"]], 3),
    c(0.21171839076346, 0.252045727972423, 0.252045727972423))
expect_equal(head(ctd[["conductivity"]], 3),
    c(3.107, 6.01, 8.992))
expect_equal(head(ctd[["time"]], 3),
    as.POSIXct(c("2021-07-21 17:36:46.17", "2021-07-21 17:36:46.21", "2021-07-21 17:36:46.25"),
    tz="UTC"))

