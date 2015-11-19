if (!interactive()) png("777c.png")
library(oce)
library(testthat)
try(source("~/src/oce/R/adp.R"))
try(source("~/src/oce/R/adp.rdi.R"))
file <- "/data/archive/sleiwex/2008/fielddata/2008-07-04/Coriolis/Ship_ADCP/leg2001_000000.ENX"
if (1 == length(list.files(pattern="*.ENX"))) {
    ## easier to debug without skipping through the file
    d <- read.adp.rdi(file, from=1, to=20, debug=999) ## 999 browses read.adp.rdi()
    ## expect_true('br' %in% names(d@data), info="This file should have bottom range, br")
    ## expect_true('bv' %in% names(d@data), info="This file should have bottom velocity, bv")
    par(mfrow=c(2,1))
    plot(d, which="bottomRange")
    plot(d, which="bottomVelocity")
    print(head(d[["br"]]))
    print(head(d[["bv"]]))
} else {
    message("cannot run the test in 777a.R because it needs a file named ", file)
}
if (!interactive()) dev.off()
