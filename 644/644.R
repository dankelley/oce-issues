library(oce)
try(source("~/src/oce/R/oce.R"))
try(source("~/src/oce/R/ctd.R"))
## test inference of conductivity unit
files <- c("01dk.cnv", "02dk.cnv", "03dk.cnv")
expect <- c("unknown", "mS/cm", "unknown")
for (i in seq_along(files)) {
    d <- read.oce(files[i])
    cat("File", files[i], "has conductivity unit: ", d[["conductivityUnit"]], "\n")
    stopifnot(all.equal(d[["conductivityUnit"]], expect[i]))
}

