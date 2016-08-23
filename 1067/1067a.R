library(oce)
library(testthat)
min <- 10000
max <- 20000
x1 <- c(3715, 7546, 10903, 13386, 15196, 15371, 55748, 71488)
x2 <- despike(x1, reference="trim",min=min,max=max, replace = "reference")
print(data.frame(x1,x2))
x3 <- x1
x3[x3<min] <- min
x3[x3>max] <- max
expect_equal(x2, x3)

