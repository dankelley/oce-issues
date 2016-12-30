library(oce)
library(testthat)
d <- read.oce("CTD_98911_1P_1_DN.txt")
expect_equal(length(d[["theta"]]), 127)

