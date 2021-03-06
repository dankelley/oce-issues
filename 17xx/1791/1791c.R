library(oce)
library(ncdf4)
# if (file.exists("~/git/oce/R/argo.R")) source("~/git/oce/R/argo.R")
file <- "BD6901494_352.nc"
if (!file.exists(file))
    download.file("https://data-argo.ifremer.fr/dac/coriolis/6901494/profiles/BD6901494_352.nc", file)

d <- read.argo(file, debug=3)
namesMetadata <- names(d@metadata)
namesMetadata[grep("pres", namesMetadata)]
namesMetadata[grep("psal", namesMetadata)]
namesMetadata[grep("temp", namesMetadata)]

sort(names(d@metadata))

oce::vectorShow(d[["pressure"]])
oce::vectorShow(d[["presMed"]])
oce::vectorShow(d[["psalMed"]])
oce::vectorShow(d[["psalStd"]])
oce::vectorShow(d[["tempMed"]])
oce::vectorShow(d[["tempStd"]])
