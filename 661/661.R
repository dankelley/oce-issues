library(oce)
source("~/src/oce/R/map.R")
A <- cbind(360-53.0729, 46.6597) # Cape Race
B <- cbind(360-43.9046, 59.7767) # Farewell
geodGc(c(A[1], B[1]), c(A[2], B[2]), 1)
