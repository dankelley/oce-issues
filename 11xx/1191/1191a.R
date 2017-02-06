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
    d1 <- handleFlags(d)               # 1=good 4=bad
    d2 <- handleFlags(d, flags=list(all=c(0, 3:9)), action=list("NA")) # expect same output as d1
    d3 <- handleFlags(d, flags=list(all=c(3:9)), action=list("NA"))
    d4 <- handleFlags(d, flags=list(all=c(1,2)), action=list("NA")) # should differ from d1
    cat("d  (built-in data)\n")
    summary(d)
    cat("d1 (default flag handling; expect different from d)\n")
    summary(d1)
    cat("d2 (equivalent to default flag handling; expect same as d1)\n")
    summary(d2)
    cat("d3 (equivalent to default flag handling; expect same as d1)\n")
    summary(d3)
    cat("d4 (sets flag=1,2 to NA ... but we don't have such cases; expect same as d1)\n")
    cat("here is why I say no such cases...\n")
    cat("   flag=1 has", sum(1==d[["salinityFlag"]]), "cases\n")
    cat("   flag=2 has", sum(2==d[["salinityFlag"]]), "cases\n")
    summary(d4)
} else {
    message("cannot run this test without a (private) test file\n")
}
