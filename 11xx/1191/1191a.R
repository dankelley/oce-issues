library(oce)
if (1 == length(list.files(path=".", pattern="^ct21-36-07_prof.nc$"))) {
    d <- read.argo("~/Desktop/ct21-36-07_prof.nc")
    ## learn about the flags in the data; I plan to make 'summary()' tell this

    ## NOTE: the above reveals that the only salinity flags in this file are 1 (good) and 4 (bad).
    d1 <- handleFlags(d, debug=2)               # default: 1=good, 0=bad, 2:9=bad
    d2 <- handleFlags(d, flags=list(c(0, 3:9)), action=list("NA"), debug=2)
    d3 <- handleFlags(d, flags=list(c(3:9)), action=list("NA"), debug=2)
    d4 <- handleFlags(d, flags=list(salinity=c(1,2)), debug=2)
    cat("\n\n\n")
    cat("d: with no flag handling\n")
    summary(d)
    cat("\n\n\n")
    cat("d1: Default flag handling, should be different to d. Should be no S remaining [result: OK]\n")
    summary(d1)
    cat("\n\n\n")
    cat("d2: should be same as d1. [result: OK]\n")
    summary(d2)
    cat("\n\n\n")
    cat("d3: expect same as d2, since no flag=0 cases. [result: OK]\n")
    summary(d3)
    cat("\n\n\n")
    cat("d4: expect the same as d, since salinity has no flag=1,2 cases. [result: PASS]\n")
    cat("here is why I say no such cases...\n")
    cat("   flag=1 has", sum(1==d[["salinityFlag"]]), "cases\n")
    cat("   flag=2 has", sum(2==d[["salinityFlag"]]), "cases\n")
    summary(d4)
} else {
    message("cannot run this test without a (private) test file\n")
}
