# Test against a variety of ODF files, including some from the "odf_transform"
# branch of https://github.com/cioos-siooc/cioos-siooc_data_transform.git

library(oce)

source("~/git/oce/R/oce.R")
source("~/git/oce/R/misc.R")
source("~/git/oce/R/odf.R")

options(width=200)
files <- list.files(".", "*.(ODF)|(odf)$", full.names=TRUE)[6]
n <- length(files)
for (i in seq_along(files)) {
    cat(sprintf("\n\n~~~~~~~~~~~~~~~~~~~~~~~\n~~~ TEST %3d of %3d ~~~\n~~~~~~~~~~~~~~~~~~~~~~~\n\n", i, n), sep="")
    d <- read.oce(files[i])
    summary(d)
}
