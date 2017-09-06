library(testthat)
library(oce)
a <- seq(0, 10, 1)
b <- c(1.2, 7.3)

i <- findInOrdered(a, b)
j <- findInterval(b, a)

expect_equal(i, c(1, 8))
expect_equal(j, c(1, 8))

