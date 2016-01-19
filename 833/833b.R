## Translate from argo netcdf names to oce names.
library(oce)
library(ncdf4)
argoDataNames <- function(names)
{
    names <- gsub("CYCLE_NUMBER", "cycle", names)
    names <- gsub("PRES", "pressure", names)
    names <- gsub("PSAL", "salinity", names)
    names <- gsub("TEMP", "temperature", names)
    names <- gsub("_([a-z])", "\\U\\1", tolower(names), perl=TRUE)
    names <- gsub("Qc$", "QC", names)
    names
}

f <- nc_open("/Users/kelley/src/oce/create_data/argo/6900388_prof.nc")
ncNames <- names(f$var)
oceNames <- argoDataNames(ncNames)
print(data.frame(ncNames, oceNames))

stationParameters <- argoDataNames(gsub(" *$", "", unique(as.vector(ncvar_get(f, "STATION_PARAMETERS")))))
print(paste("stationParameters:", paste(stationParameters, collapse=" ")))
print("Plan: save stationParameters in @data, along with time, longitude and latitude (PLUS OTHERS??)\n")
