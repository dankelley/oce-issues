# Test against a fairly wide variety of ODF files, including some from the
# "odf_transform" branch of
# https://github.com/cioos-siooc/cioos-siooc_data_transform.git

# git clone https://github.com/dankelley/oce-issues.git

library(oce)
options(width=200)

# Uncomment the next lines for testing, saving the time it takes to build oce.

# source("~/git/oce/R/oce.R")
# source("~/git/oce/R/misc.R")
# source("~/git/oce/R/odf.R")
# source("~/git/oce/R/ctd.R")
# source("~/git/oce/R/ctd.odf.R")

files <- list.files(".", "*.(ODF)|(odf)$", full.names=TRUE)
n <- length(files)
for (i in seq_along(files)) {
    cat(sprintf("\n\n~~~~~~~~~~~~~~~~~~~~~~~\n~~~ TEST %3d of %3d ~~~\n~~~~~~~~~~~~~~~~~~~~~~~\n\n", i, n), sep="")
    d <- read.oce(files[i])
    summary(d)
}
