DP <- 0.128 # inferred pressure change in matlab
library(R.matlab)
library(oce)
library(testthat)
options(digits=10)
options(digits.secs=4)

m <- readMat("adcp.mat")
cat("reading d1\n")
d1 <- read.oce("adcp.000", from=1, to=9)
if (length(ls(pattern="^ldc$")))
    cat("d1: diff(ensembleStart)= ", paste(diff(ldc$ensembleStart), collapse=" "), "\n")

cat("reading d2\n")
d2 <- read.oce("adcp.000", from=1, to=9, by=2)
if (length(ls(pattern="^ldc$")))
    cat("d2: diff(ensembleStart)= ", paste(diff(ldc$ensembleStart), collapse=" "), "\n")
expect_equal(d1[["time"]][seq.int(1, 9, 2)], d2[["time"]])
expect_equal(d1[["pressure"]][seq.int(1, 9, 2)], d2[["pressure"]])
expect_equal(d1[["v"]][seq.int(1, 9, 2),,], d2[["v"]])


