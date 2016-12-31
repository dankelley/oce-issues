library(oce)
library(testthat)
debug <- 0                             # set to 5 or so for full debugging info

if (0 == length(ls(pattern="^a$"))) {
    message("readin 'a' and 'b'")
    a <- read.oce("A_test2.pd0", debug=debug)
    b <- read.oce("B_test2.pd0", debug=debug)
} else {
    message("using cached values of 'a' and 'b'")
}

expect_identical(a[["time"]], b[["time"]])
expect_identical(a[["distance"]], b[["distance"]])
message("NOTE: the first heading differs but the rest are identical. (roll and pitch are ok)")
head(a[["heading"]], 4)
head(b[["heading"]], 4)
expect_identical(tail(a[["heading"]],-1), tail(b[["heading"]],-1))
expect_identical(a[["roll"]], b[["roll"]])
expect_identical(a[["pitch"]], b[["pitch"]])
expect_identical(a[["temperature"]], b[["temperature"]])
expect_identical(a[["salinity"]], b[["salinity"]])
## expect_identical(a[["depth"]], b[["depth"]])
expect_identical(a[["pressure"]], b[["pressure"]])

# summary(a)
# summary(b)

options(digits=10)

## first profile, first 3 bins, all 4 beams
a[["v"]][1, 1:3, 1:4]
b[["v"]][1, 1:3, 1:4]

## second profile, first 3 bins, all 4 beams
a[["v"]][2, 1:3, 1:4]
b[["v"]][2, 1:3, 1:4]

