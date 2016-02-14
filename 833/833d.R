rm(list=ls())

library(ncdf4)
f <- try(nc_open("6900388_prof.nc"), silent=TRUE)
if (inherits(f, "try-error"))
    stop("you need to have '6900388_prof.nc' here")

argoDataNames <- function(names)
{
    names <- gsub("CYCLE_NUMBER", "cycle", names)
    names <- gsub("PRES", "pressure", names)
    names <- gsub("PSAL", "salinity", names)
    names <- gsub("TEMP", "temperature", names)
    names <- gsub("_ADJUSTED", "Adjusted", names)
    names <- gsub("_QC", "Qc", names)
    names <- gsub("_ERROR", "Error", names)
    names
}


## http://www.argodatamgt.org/Media/Medias-Argo-Data-Management/Argo-documentation/General-documentation/Data-format/Obsolete-documents/Argo-user-s-manual-version-2.3-July-13th-2010
## sec 2.2.4, page 17 items stored for each profile are:
## <PARAM> <PARAM>_QC <PARAM>_ADJUSTED <PARAM>_ADJUSTED_QC <PARAM>_ADJUSTED_ERROR
getProfile <- function(f, name)
{
    res <- NULL
    try(res <- ncvar_get(f, item), silent=TRUE)
    res
}
## FIXME: what if different profiles have different data? This seems to be
## permitted, maybe.
items <- gsub(" *$", "", unique(as.vector(ncvar_get(f, "STATION_PARAMETERS"))))
variants <- 4
res <- list()
for (item in items) {
    res[[item]] <- getProfile(f, item)
    res[[paste(item, "_QC", sep="")]] <- getProfile(f, paste(item, "_QC"))
    res[[paste(item, "_ADJUSTED", sep="")]] <- getProfile(f, paste(item, "_ADJUSTED"))
    res[[paste(item, "_ADJUSTED_QC", sep="")]] <- getProfile(f, paste(item, "_ADJUSTED_QC"))
    res[[paste(item, "_ADJUSTED_ERROR", sep="")]] <- getProfile(f, paste(item, "_ADJUSTED_ERROR"))
}
str(res)
names(res) <- argoDataNames(names(res))
str(res)
