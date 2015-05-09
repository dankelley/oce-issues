library(oce)
try(source("~/src/oce/R/oce.R"))
try(source("~/src/oce/R/ctd.R"))
## test inference of conductivity unit
files <- c("01.cnv", "02.cnv")
expect <- c("unknown", "mS/cm")
for (i in seq_along(files)) {
    d <- read.oce(files[i])
    cat("File ", files[i], " has conductivity unit: ", d[["conductivityUnit"]], "\n")
    stopifnot(all.equal(d[["conductivityUnit"]], expect[i]))
}

