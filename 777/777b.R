if (!interactive()) png("777b.png")
library(oce)
library(testthat)
try(source("~/src/oce/R/adp.R"))
try(source("~/src/oce/R/adp.rdi.R"))
file <- "MS2015-150kHz002_000001.ENX"
if (1 == length(list.files(pattern="*.ENX"))) {
    ## easier to debug without skipping through the file
    d <- read.adp.rdi(file, from=1, to=10) ## 999 browses read.adp.rdi()
    ## expect_true('br' %in% names(d@data), info="This file should have bottom range, br")
    ## expect_true('bv' %in% names(d@data), info="This file should have bottom velocity, bv")
    par(mfrow=c(2,5))
    plot(d, which="bottomRange")
    plot(d, which="bottomRange1")
    plot(d, which="bottomRange2")
    plot(d, which="bottomRange3")
    plot(d, which="bottomRange4")
    plot(d, which="bottomVelocity")
    plot(d, which="bottomVelocity1")
    plot(d, which="bottomVelocity2")
    plot(d, which="bottomVelocity3")
    plot(d, which="bottomVelocity4")
    print(head(d[["br"]]))
    print(head(d[["bv"]]))
} else {
    message("cannot run the test in 777a.R because it needs a file named ", file)
}
if (!interactive()) dev.off()
