library(oce)
if (1 == length(list.files(path=".", pattern="^ct21-36-07_prof.nc$"))) {
    d <- read.argo("~/Desktop/ct21-36-07_prof.nc")
    ## learn what sort of flats we have
    for(flag in 0:5) {
        cat("flag", flag, "\n") 
        for (name in names(d[["flags"]])) {
            cat("  ", name, "has", sum(d[["flags"]][[name]]==flag, na.rm=TRUE),"flagged\n")
        }
    }
    ## NOTE: the above reveals that the only flags in this file are 1 (good) and 4 (bad).
    d1 <- handleFlags(d)               # 1=good 4=bad
    d2 <- handleFlags(d, flags=list(all=c(0, 3:9)), action=list("NA"))
    d3 <- handleFlags(d, flags=list(all=c(3:9)), action=list("NA"))
    d4 <- handleFlags(d, flags=list(all=c(1,2)), action=list("NA")) # should differ from d1
    summary(d)
    summary(d1)
    summary(d2)
    summary(d3)
    summary(d4)
} else {
    message("cannot run this test without a (private) test file\n")
}
