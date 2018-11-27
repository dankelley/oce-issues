library(oce)
library(testthat)
## Note the use of a hard-wired name for a file available only to
## the developers. Also, we check that the returned object is of
## the oce class, which means that the tests only get done for
## either the "ad2cp" branch of oce, or branches into which
## that has been merged.
f <- "~/Dropbox/oce_ad2cp/labtestsig3.ad2cp" # DK only tests
if (file.exists(f)) {
    d <- read.ad2cp(f, 1, 100, 1)
    if (!interactive()) png("1219e_1.png")
    plot(d)
   if (!interactive()) dev.off()
}

