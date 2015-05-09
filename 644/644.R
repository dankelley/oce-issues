library(oce)
try(source("~/src/oce/R/oce.R"))
try(source("~/src/oce/R/ctd.R"))
## test inference of conductivity unit
ctds <- list.files(".", "*.cnv")
for (ctd in ctds) {
    d <- read.oce(ctd)
    message("File ", ctd, " has conductivity unit: ", d[["conductivityUnit"]])
}

