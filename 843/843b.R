library(ncdf4)
s <- "http://coastwatch.pfeg.noaa.gov/erddap/griddap/jplG1SST.nc?SST%5B(2016-01-02T12:00:00Z)%5D%5B(38):(55)%5D%5B(-66.):(-45)%5D"
if (!length(list.files(pattern="^a.nc$")))
    download.file(s, "a.nc")
library(oce)

## f <- nc_open("a.nc")
## if (!interactive()) png("843a.png")
## latitude <- ncvar_get(f, "latitude")
## longitude <- ncvar_get(f, "longitude")
## SST <- ncvar_get(f, "SST")


setClass("satellite", contains="oce")
setMethod(f="initialize",
          signature="satellite",
          definition=function(.Object, filename, subclass) {
              if (!missing(filename))
                  .Object@metadata$filename <- filename
              .Object@processingLog$time <- as.POSIXct(Sys.time())
              .Object@processingLog$value <- if (missing(subclass))
                  "create 'satellite' object" else paste("create '", subclass, "' object")
              return(.Object)
          })

setMethod(f="summary",
          signature="satellite",
          definition=function(object, ...) {
              cat("Satellite Summary\n-----------------\n\n")
              showMetadataItem(object, "filename",   "Data file:           ")
              showMetadataItem(object, "satellite",  "Satellite:           ")
              lon <- object@metadata$longitude
              lat <- object@metadata$latitude
              if (length(lon) > 2) {
                  cat("* Longitude:           ",
                      lon[1], ", ", lon[2],  ", ..., ", tail(lon, 1), "\n", sep="")
              } else {
                  cat("* Longitude:           ",
                      paste(lon, collapse=", "), "\n", sep="")
              }
              if (length(lat) > 2) {
                  cat("* Latitude:            ",
                      lat[1], ", ", lat[2],  ", ..., ", tail(lat, 1), "\n", sep="")
              } else {
                  cat("* Latitude:            ",
                      paste(lat, collapse=", "), "\n", sep="")
              }
              cat("* Time:                ",
                  format(object@metadata$time, "%Y-%m-%d %H:%M:%S %z"), "\n", sep="")
              for (name in names(object@data)) {
                  object@data[[name]] <- object[[name]] # translate to science units
              }
              callNextMethod()
          })

setMethod(f="plot",
          signature=signature("satellite"),
          definition=function(x, y, debug=getOption("oceDebug"), ...)
          {
              oceDebug(debug, "plot.satellite(..., y=c(",
                       if (missing(y)) "(missing)" else y, ", ...) {\n", sep="", unindent=1)
              if (missing(y))
                  stop("must indicate what to plot")
              if ("zlab" %in% names(list(...))) imagep(x[["longitude"]], x[["latitude"]], x[[y]], ...)
              else imagep(x[["longitude"]], x[["latitude"]], x[[y]], zlab=y, ...)
              oceDebug(debug, "} # plot.satellite()\n", unindent=1)
          })

## g1sst subclass
setClass("g1sst", contains="satellite")
 
read.g1sst <- function(filename)
{
    f <- ncdf4::nc_open("a.nc")
    res <- new("g1sst", filename=filename)
    res@metadata$longitude <- ncdf4::ncvar_get(f, "longitude")
    res@metadata$latitude <- ncdf4::ncvar_get(f, "latitude")
    res@metadata$time <- numberAsPOSIXct(ncvar_get(f, "time"))
    res@metadata$units$SST <- list(unit=expression(degree*C), scale="ITS-90")
    res@metadata$satellite <- "G1SST"
    res@data$SST <- ncdf4::ncvar_get(f, "SST")
    res
}

d <- read.g1sst(s)

summary(d)
if (!interactive()) png("843b.png")
plot(d, "SST", col=oceColorsJet)
if (!interactive()) dev.off()
