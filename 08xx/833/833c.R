## http://www.argodatamgt.org/Media/Medias-Argo-Data-Management/Argo-documentation/General-documentation/Data-format/Obsolete-documents/Argo-user-s-manual-version-2.3-July-13th-2010
## Back to square 1 ... let's see what we can find out about a .nc file.
library(ncdf4)
f <- nc_open("6900388_prof.nc")
names(f$var)
sp <- gsub(" *$", "", ncvar_get(f, "STATION_PARAMETERS")[,1])
var <- names(f$var)
pvar <- var[grep("PROFILE_", var)]
for (pv in pvar) {
    cat("pv: ", pv, "\n")
    temp <- var[grep(pv, var)]
    for (a in temp) {
        cat(sprintf("%25s", a))
        str(ncvar_get(f, a))
    }
}

## why don't these do anything?

ncatt_get(f, varid=0, attname="DATE_TIME") # nc varid attname
ncatt_get(f, 0, "N_PROF")
ncatt_get(f, 0, "N_PARAM", TRUE)
ncatt_get(f, varid=0, attname="N_LEVELS")

ncvar_get(f, "DATA_TYPE")

#ncvar_get(f, "DATE_TIME")
#ncvar_get(f, "N_PROF")
#ncvar_get(f, "N_PARAM")
#ncvar_get(f, "N_LEVELS")

for (i in 1:f$ndims) {
    d <- f$dim[[i]]
    message(sprintf("%2d: %10s holds %4d items", i, d$name, d$len))
}

## Below is an ugly way to reach inside to capture the dimensions,
## but I cannot see how to use ncdf4 to read these things. Note that
## these things are easily found with
##
##    ncdump -h 6900388_prof.nc
##
## It seems that ncdf4 has made a design choice not to these
## things be discovered simply. They *can* be discovered indirectly
## with
##
##    dim(ncvar_get(nc_open(".."), "TEMP"))
##
## for example. But how do we know that 'TEMP' is in the file?

dimNames <- unlist(lapply(1:f$ndims, function(i) f$dim[[i]]$name))
N_PROF <- length(f$dim[[which("N_PROF" == dimNames)]]$vals)
stopifnot(207==N_PROF)
N_LEVELS <- length(f$dim[[which("N_LEVELS" == dimNames)]]$vals)
stopifnot(56==N_LEVELS)
N_PARAM <- length(f$dim[[which("N_PARAM" == dimNames)]]$vals)
stopifnot(3==N_PARAM)

## sec 2.2.4, page 17 items stored for each profile are:
## <PARAM> <PARAM>_QC <PARAM>_ADJUSTED <PARAM>_ADJUSTED_QC <PARAM>_ADJUSTED_ERROR
getProfile <- function(f, name)
{
    res <- NULL
    try(res <- ncvar_get(f, item), silent=TRUE)
    res
}
items <- gsub(" *$", "", unique(as.vector(ncvar_get(f, "STATION_PARAMETERS"))))
variants <- 4
res <- list()
for (item in items) {
    res[[item]] <- getProfile(item)
    res[[paste(item, "_QC", sep="")]] <- getProfile(f, paste(item, "_QC"))
    res[[paste(item, "_ADJUSTED", sep="")]] <- getProfile(f, paste(item, "_ADJUSTED"))
    res[[paste(item, "_ADJUSTED_QC", sep="")]] <- getProfile(f, paste(item, "_ADJUSTED_QC"))
}
str(res)
