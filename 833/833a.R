## Determine whether all fields in an argo file can be read. The answer
## is that the HISTORY_* items cannot be read.
library(oce)
library(ncdf4)
f <- nc_open("/Users/kelley/src/oce/create_data/argo/6900388_prof.nc")
varNames <- names(f$var)
varNames
for (name in varNames) {
    t <- try(v <- ncvar_get(f, name), silent=TRUE)
    if (!inherits(t, "try-error")) message(paste("name: ", name, " can be read OK"))
}

