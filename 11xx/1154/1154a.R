library(oce)
library(testthat)
d <- read.oce("CTD_98911_1P_1_DN.txt")

## 1. test access
expect_equal(length(d[["theta"]]), 127)
expect_equal(head(d[['theta']]), c(0.0346, 0.1563, 0.2153, 0.1970, 0.1916, 0.2141))

## 2. test assignment
d[["theta"]] <- seq_along(d[["pressure"]])
expect_equal(length(d[["theta"]]), 127)
expect_equal(head(d[['theta']]), 1:6)

