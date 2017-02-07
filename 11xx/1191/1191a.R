library(oce)
if (1 == length(list.files(path=".", pattern="^ct21-36-07_prof.nc$"))) {
    d <- read.argo("~/Desktop/ct21-36-07_prof.nc")
    ## learn what sort of flats we have
    for(flag in 0:4) {
        cat("flag", flag, "\n") 
        for (name in names(d[["flags"]])) {
            cat("  ", name, "has", sum(d[["flags"]][[name]]==flag, na.rm=TRUE),"flagged\n")
        }
    }
    ## NOTE: the above reveals that the only flags in this file are 1 (good) and 4 (bad).
    d1 <- handleFlags(d, debug=2)               # default: 1=good, 0=bad, 2:9=bad
    d2 <- handleFlags(d, flags=list(c(0, 3:9)), action=list("NA"), debug=2)
    d3 <- handleFlags(d, flags=list(c(3:9)), action=list("NA"), debug=2)
    d4 <- handleFlags(d, flags=list(c(1,2)), action=list("NA"), debug=2)
    cat("\n\n\n")
    cat("d: with no flag handling\n")
    summary(d)
    cat("\n\n\n")
    cat("d1: Default flag handling, should be different to d. [result: OK]\n")
    summary(d1)
    cat("\n\n\n")
    cat("d2: should be same as d1. [result: ]\n")
    summary(d2)
    cat("\n\n\n")
    cat("d3: expect same as d2, since no flag=0 cases. [result: ]\n")
    summary(d3)
    cat("\n\n\n")
    cat("d4: expect same as d, since no flag=1,2 cases. [result: ]\n")
    cat("here is why I say no such cases...\n")
    cat("   flag=1 has", sum(1==d[["salinityFlag"]]), "cases\n")
    cat("   flag=2 has", sum(2==d[["salinityFlag"]]), "cases\n")
    summary(d4)
} else {
    message("cannot run this test without a (private) test file\n")
}
