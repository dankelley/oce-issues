library(ncdf4)
library(oce)

file <- "BD6901494_352.nc"
if (!file.exists(file))
    download.file("https://data-argo.ifremer.fr/dac/coriolis/6901494/profiles/BD6901494_352.nc", file)
nc <- nc_open(file)
DIM <- dim(ncvar_get(nc, "PRES"))
VAR <- NULL
for (name in sort(names(nc$var))) {
    d <- ncvar_get(nc, name)
    if (identical(dim(d), DIM))
        VAR <- c(VAR, name)
}
cat("The following vars have same dimension as PRES (pressure): ", paste(sort(VAR), collapse=" "), "\n")

# vars listed in STATION_PARAMETERS (trim the blank ones)
varNamesNetcdf <- unique(as.vector(trimws(ncvar_get(nc,"STATION_PARAMETERS"))))
varNamesNetcdf <- varNamesNetcdf[varNamesNetcdf != ""]
sort(varNamesNetcdf)

# vars in oce object. We trim time, longitude and latitude because they are
# inserted as special cases. Also, to compare with the netCDF values, we trim
# the Error and Adjusted fields.
d <- read.argo(file)
varNamesOce <- names(d[["data"]])
varNamesOce <- varNamesOce[!varNamesOce %in% c("time", "latitude", "longitude")]
varNamesOce <- varNamesOce[!grepl("Error", varNamesOce)]
varNamesOce <- varNamesOce[!grepl("Adjusted", varNamesOce)]
sort(varNamesOce)

