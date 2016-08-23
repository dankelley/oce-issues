library(oce)
library(testthat)
min <- 10000
max <- 20000
x1 <- c(3715, 7546, 10903, 13386, 15196, 15371, 55748, 71488)

x2 <- despike(x1, reference="trim", min=min, max=max, replace="reference")
x3 <- x1
x3[1:2] <- 10903 # result from approx() with rule=2
x3[7:8] <- 15371 # result from approx() with rule=2
expect_equal(x2, x3)

x4 <- despike(x1, reference="trim",min=min,max=max, replace="NA")
x5 <- x1
x5[x5<min] <- NA
x5[x5>max] <- NA
expect_equal(x4, x5)

