library(oce)
library(ncdf4)
files <- c("025.nc", "040.nc", "047.nc")
nfiles <- length(files)
s <- vector("list", nfiles)

## Change NaN to NA, and make into a vector, not a one-column matrix.
fixNaN <- function(x) {
    if (is.numeric(x)) x[!is.finite(x)] <- NA
    as.vector(x)
}
for (ifile in seq_along(files)) {
    message("Processing data in file '", files[ifile], "'")
    ## Create a "parent-level" oce object.
    this <- new("oce")
    d <- nc_open(files[ifile])
    ## Put scalars into the 'metadata' slot.
    this@metadata$filename <- fixNaN(files[ifile])
    this@metadata$longitude <- fixNaN(ncvar_get(d, "lon"))
    this@metadata$latitude <- fixNaN(ncvar_get(d, "lat"))
    timevec <- ncvar_get(d, "date")
    t <- ISOdatetime(timevec[1],timevec[2],timevec[3],timevec[4],timevec[5],timevec[6],tz="UTC")
    this@metadata$time <- t
    message(" sample at ", format(t))
    ## Put some vectors into the 'data' slot.
    ## NB. there are quite a lot of columns to choose from; below is a guess only
    this@data$pressure <- fixNaN(ncvar_get(d, "p"))
    this@metadata$waterDepth <- max(this@data$pressure)
    this@data$u <- fixNaN(ncvar_get(d, "u"))
    this@data$v <- fixNaN(ncvar_get(d, "v"))
    this@data$temperature <- fixNaN(ncvar_get(d, "ctd_t"))
    this@data$salinity <- fixNaN(ncvar_get(d, "ctd_s"))
    s[[ifile]] <- this
}
if (!interactive()) png("648a.png")
par(mfrow=c(2,2))
plot(sec, which="salinity")
plot(sec, which="temperature")
plot(sec, which="u")
plot(sec, which="v")
if (!interactive()) dev.off()
