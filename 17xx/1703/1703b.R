library(argoFloats)
library(ncdf4)
library(oce)
#source("~/git/oce/R/argo.R")
files <- c("~/git/oce/create_data/argo/6900388_prof.nc", "~/data/argo/D3900740_193.nc")
for (file in files) {
    if (file.exists(file)) {
        a <- read.argo(file)
        n <- nc_open(file)
        hqt <- ncvar_get(n, "HISTORY_QCTEST")
        stopifnot(all.equal(a[["HISTORY_QCTEST"]], gsub("[ ]*$", "", hqt)))
        message("HISTORY_QCTEST is ok in '", file, "'; dim() is ", paste(dim(hqt), collapse="x"))
    } else {
        message("cannot check '", file, "' because it is not on this filesystem")
    }
}

source("~/git/argoFloats/R/AllClass.R")
A <- readProfiles(file)
A[["HISTORY_QCTEST"]]
