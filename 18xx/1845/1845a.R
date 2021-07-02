library(oce)
library(testthat)

d1 <- read.adp.rdi("adp_2.000", debug=0) # second 100K (does not start with 7F7F)
d2 <- read.adp.rdi("adp_12.000", debug=0) # first and second 100K (starts with 7F7F)

# Ensure that things match up
N <- 157                               # num. profiles in d2 but not d1
skip <- 1:N
expect_equal(d1[["time"]], d2[["time"]][-skip])
expect_equal(d1[["pressure"]], d2[["pressure"]][-skip])
expect_equal(d1[["pressureStd"]], d2[["pressureStd"]][-skip])
expect_equal(d1[["heading"]], d2[["heading"]][-skip])
expect_equal(d1[["headingStd"]], d2[["headingStd"]][-skip])
expect_equal(d1[["roll"]], d2[["roll"]][-skip])
expect_equal(d1[["rollStd"]], d2[["rollStd"]][-skip])
expect_equal(d1[["pitch"]], d2[["pitch"]][-skip])
expect_equal(d1[["pitchStd"]], d2[["pitchStd"]][-skip])
expect_equal(d1[["salinity"]], d2[["salinity"]][-skip])
expect_equal(d1[["temperature"]], d2[["temperature"]][-skip])
expect_equal(d1[["attitude"]], d2[["attitude"]][-skip])
expect_equal(d1[["v"]], d2[["v"]][-skip,,])
expect_equal(d1[["a"]], d2[["a"]][-skip,,])
expect_equal(d1[["q"]], d2[["q"]][-skip,,])
expect_equal(d1[["g"]], d2[["g"]][-skip,,])

