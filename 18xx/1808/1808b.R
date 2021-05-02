# vim: tw=140

library(oce)
options(width=200)

file <- system.file("extdata", "CTD_BCD2014666_008_1_DN.ODF.gz", package="oce")
d <- read.odf(file)
summary(d)

# cioos branch "odf_transform"
dir <- "~/git/cioos-siooc_data_transform/projects/odf_transform/sample_data/mli_data/2020-12-23/ODF_files_MLI"
files <- list.files(dir, "*.ODF$", full.names=TRUE)

n <- length(files)
for (i in seq_along(files)) { # n=16 as of 2021-04-24
    cat(sprintf("\n\n~~~~~~~~~~~~~~~~~~~~~~~\n~~~ TEST %3d of %3d ~~~\n~~~~~~~~~~~~~~~~~~~~~~~\n", i, n), sep="")
    d <- read.oce(files[i])
    summary(d)
}
