library(oce)
library(testthat)
debug <- 0                             # set to 5 or so for full debugging info

a <- read.oce("A.pd0", debug=debug)
b <- read.oce("B.pd0", debug=debug)

expect_identical(a[["time"]], b[["time"]])
expect_identical(a[["distance"]], b[["distance"]])

summary(a)
summary(b)

options(digits=10)

## first profile, first 3 bins, all 4 beams
a[["v"]][1, 1:3, 1:4]
b[["v"]][1, 1:3, 1:4]

## second profile, first 3 bins, all 4 beams
a[["v"]][2, 1:3, 1:4]
b[["v"]][2, 1:3, 1:4]

