library(oce)
#if (file.exists("~/git/oce/R/ctd.R"))
#    source("~/git/oce/R/ctd.R")
data(section)
ctd <- section[["station", 10]]
# Test listing
print(ctd[["?"]])
# Test whether missing still works
stopifnot(is.null(ctd[["bark"]]))
# Test whether SA still works
SA <- swAbsoluteSalinity(ctd)
stopifnot(all.equal(ctd[["SA"]], SA))

