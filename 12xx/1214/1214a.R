library(oce)
library(testthat)

## 'result' should have no NA values
x <- seq(0, 95)
xbreaks <- seq(0, 100, 10)
y <- x
b <- binApply1D(x, y, xbreaks, mean)
expect_equal(length(b$xmids), length(b$result))

## should be one NA at the end of 'result'
x <- seq(0, 89)
xbreaks <- seq(0, 100, 10)
y <- x
b <- binApply1D(x, y, xbreaks, mean)
expect_equal(length(b$xmids), length(b$result))
expect_true(is.na(tail(b$result, 1)))

## should be an NA at both start and end of 'result'
x <- seq(11, 89)
xbreaks <- seq(0, 100, 10)
y <- x
b <- binApply1D(x, y, xbreaks, mean)
expect_equal(length(b$xmids), length(b$result))
expect_true(is.na(b$result[1]))
expect_true(is.na(tail(b$result, 1)))

