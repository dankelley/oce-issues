library(oce)
library(testthat)
A <- cbind(360-53.0729, 46.6597) # Cape Race
B <- cbind(360-43.9046, 59.7767) # Farewell
ll <- geodGc(c(A[1], B[1]), c(A[2], B[2]), 1)
expect_true(all(ll$longitude >= min(A[1,1], B[1,1])))
