## Note: this test was put into the oce built-test-suite
library(oce)
library(testthat)
data(ctd)
summary(ctd)
expect_equal(ctd[["time"]], ctd[["timeS"]])
expect_equal(ctd[["pressure"]], ctd[["pr"]])
expect_equal(ctd[["depth"]], ctd[["depS"]])
expect_equal(ctd[["temperature"]], T90fromT68(ctd[["t068"]]))
expect_equal(ctd[["salinity"]], ctd[["sal00"]])

