library(oce)
library(testthat)
try(source("~/src/oce/R/adp.R"))
try(source("~/src/oce/R/adp.rdi.R"))
file <- "../777/MS2015-150kHz002_000001.ENX"
if (1 == length(list.files('../777/', pattern="*.ENX"))) {
    d <- read.adp.rdi(file)
    dd <- subtractBottomVelocity(d)
} else {
    message("cannot run the test in 779a.R because it needs a file named ", file)
}
if (!interactive()) png('779a-%03d.png')
plot(d)
title('ENU velocities with Ship motion')
plot(dd, zlim=c(-0.5, 0.5))
title('ENU velocities after subtractBottomVelocity')
if (!interactive()) dev.off()
