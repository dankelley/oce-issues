# vim: tw=140
library(oce)
options(warn=3) # cause errors if units are not recognized
options(width=200)
source("~/git/oce/R/odf.R")
source("~/git/oce/R/oce.R")
source("~/git/oce/R/ctd.R")
source("~/git/oce/R/ctd.odf.R")
source("~/git/oce/R/misc.R")

# cioos branch "odf_transform"
dir <- "~/git/cioos-siooc_data_transform/projects/odf_transform/sample_data/mli_data/2020-12-23/ODF_files_MLI"
files <- list.files(dir, "*.ODF$", full.names=TRUE)

n <- length(files)
for (i in seq_along(files)[1]) { # n=16 as of 2021-04-24
    cat(sprintf("\n\n~~~~~~~~~~~~~~~~~~~~~~~\n~~~ TEST %3d of %3d ~~~\n~~~~~~~~~~~~~~~~~~~~~~~\n", i, n), sep="")
    cat(files[i], "\n", sep="")
    d <- read.oce(files[i], debug=if (i==1) 2 else 0)
    summary(d)
}
