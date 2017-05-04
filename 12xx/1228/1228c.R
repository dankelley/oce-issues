library(oce)
library(testthat)
options(digits=10)
options(digits.secs=4)

cat("Reading d0 to test default\n")
d0 <- read.oce("adcp.000")

cat("Reading d1 to test 'to' in integer form\n")
d1 <- read.oce("adcp.000", from=1, to=9)
expect_equal(length(d1[["time"]]), 9)
expect_equal(d1[["time"]], d0[["time"]][1:9])
expect_equal(length(d1[["pressure"]]), 9)
expect_equal(d1[["pressure"]], d0[["pressure"]][1:9])

cat("Reading d2, to test 'by' in integer form\n")
d2 <- read.oce("adcp.000", from=1, to=9, by=2)
expect_equal(d0[["time"]][seq.int(1, 9, 2)], d2[["time"]])
expect_equal(d0[["pressure"]][seq.int(1, 9, 2)], d2[["pressure"]])
expect_equal(d0[["v"]][seq.int(1, 9, 2),,], d2[["v"]])

cat("Reading d3, to test 'from' in integer form\n")
d3 <- read.oce("adcp.000", from=3, to=5)
expect_equal(d0[["time"]][3:5], d3[["time"]])
expect_equal(d0[["pressure"]][3:5], d3[["pressure"]])
expect_equal(d0[["v"]][3:5,,], d3[["v"]])


