library(ncdf4)
# if (file.exists("~/git/oce/R/argo.R")) source("~/git/oce/R/argo.R")
file <- "BD6901494_352.nc"
if (!file.exists(file))
    download.file("https://data-argo.ifremer.fr/dac/coriolis/6901494/profiles/BD6901494_352.nc", file)
nc <- nc_open(file)
trimws(ncvar_get(nc,"STATION_PARAMETERS"))

# Get an idea of the pressure coverage
p <- ncvar_get(nc, "PRES")
apply(p, 2, function(x) sum(is.finite(x)))
for (i in seq_len(dim(p)[2]))
    cat("Profile", i, "has pressures: ",
        paste(round(p[,i][is.finite(p[,i])], 1), collapse=" "), "\n")


