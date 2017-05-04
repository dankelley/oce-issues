library(oce)
library(testthat)
options(digits=10)
options(digits.secs=5)

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

## > d0[["time"]][1]
## [1] "2014-08-09 02:00:03 UTC"
## > d0[["time"]][3]
## [1] "2014-08-09 06:00:03.00 UTC"
## > d0[["time"]][5]
## [1] "2014-08-09 10:00:03.01 UTC"
## actually, above is 0.0199999 if inspected
## > d0[["time"]][10]
## [1] "2014-08-09 20:00:03.04 UTC"
 
cat("Reading d4, to test 'from' and 'to' in character-style time form\n")
d4 <- read.oce("adcp.000", from="2014-08-09 06:00:03.00", to="2014-08-09 10:00:03.02")
expect_equal(d4[["time"]], d0[["time"]][3:5])
expect_equal(d4[["pressure"]], d0[["pressure"]][3:5])
expect_equal(d4[["v"]], d0[["v"]][3:5,,])

cat("Reading d5, to test 'from' and 'to' in POSIX-style time form\n")
d5 <- read.oce("adcp.000", from=d0[["time"]][3], to=d0[["time"]][5])
expect_equal(d5[["time"]], d0[["time"]][3:5])
expect_equal(d5[["pressure"]], d0[["pressure"]][3:5])
expect_equal(d5[["v"]], d0[["v"]][3:5,,])

cat("Reading d6, to test 'from' in time form\n")
d6 <- read.oce("adcp.000", from="2014-08-09 06:00:03.00", to="2014-08-09 10:00:00:03.01")
expect_equal(d6[["time"]], d0[["time"]][3:5])
expect_equal(d6[["pressure"]], d0[["pressure"]][3:5])
expect_equal(d6[["v"]], d0[["v"]][3:5,,])

cat("Reading d7, to test 'by' in time form\n")
d7 <- read.oce("adcp.000", from=d0[["time"]][1], to=d0[["time"]][10], by="4:00:00")
## this is tricky, because the time increment is not actually 2 hours!
expect_equal(d7[["time"]], d0[["time"]][seq(1, 10, 2)])
expect_equal(d7[["pressure"]], d0[["pressure"]][seq(1, 10, 2)])
expect_equal(d7[["v"]], d0[["v"]][seq(1, 10, 2),,])

