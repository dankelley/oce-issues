## read, then grid and plot, VIIRS data
library(oce)

## This block could go into oce <<<
setClass("viirs", contains="satellite")
setMethod(f="initialize", # gridded variety
          signature="viirs",
          definition=function(.Object, file, longitude, latitude, SST, time) {
              .Object@metadata$file<- if (missing(file)) "?" else file
              if (missing(longitude)) stop("must supply longitude")
              if (missing(latitude)) stop("must supply latitude")
              if (missing(SST)) stop("must supply SST")
              .Object@metadata$time <- if (missing(time)) NULL else time
              .Object@metadata$gridded <- is.matrix(longitude)
              .Object@data$longitude <- longitude
              .Object@data$latitude <- latitude
              .Object@data$SST <- SST
              .Object@processingLog$time <- as.POSIXct(Sys.time())
              .Object@processingLog$value <- "create 'viirs' object"
              return(.Object)
          })
viirsGrid <- function(viirs, decimate=4, fillgap=4)
{
    res <- viirs # will change in-place
    SST <- viirs[["SST"]]
    longitude <- viirs[["longitude"]]
    latitude <- viirs[["latitude"]]
    n <- sqrt(length(SST))
    lonG <- pretty(longitude, n/decimate)
    latG <- pretty(latitude, n/decimate)
    G <- if (fillgap <= 0) binMean2D(longitude, latitude, SST, lonG, latG)
        else binMean2D(longitude, latitude, SST, lonG, latG, fill=TRUE, fillgap=fillgap)
    res@metadata$gridded <- TRUE
    res@data$longitude <- G$xmids
    res@data$latitude <- G$ymids
    res@data$SST <- G$result
    res
}

read.viirs <- function(file)
{
    if (!require(rhdf5))
        stop("must install 'rhd5' package for read.viirs to work")
    dir <- h5ls(file)
    ## Guessing on the unit of SST. The docs suggest maybe Kelvin, but a 
    ## history of 'sst' computed next looks more oceanographic to me.
    SST <- h5read(file, "All_Data/VIIRS-SST-EDR_All/SkinSST")
    bad <- SST > 2^16-1 - 10 # top two values seem to be NA codes
    SST <- SST / 1000
    SST[bad] <- NA
    ## Lon and lat are straightforwd
    longitude <- h5read(file, "All_Data/VIIRS-MOD-GEO-TC_All/Longitude")
    latitude <- h5read(file, "All_Data/VIIRS-MOD-GEO-TC_All/Latitude")
    ## Time is a vector (length 192) and I don't know what that means, so I just
    ## take a mean value.  The units are weird; see page 307 of viirs-sdr-dataformat.pdf
    owarn <- options('warn')$warn # quieten a warning msg
    options(warn=-1)
    MidTime <- h5read(file, "All_Data/VIIRS-MOD-GEO-TC_All/MidTime", bit64conversion="double")
    options(warn=owarn)
    time <- as.POSIXct("1958-01-01 00:00:00", tz="UTC") + mean(MidTime/1e6)
    rval <- new("viirs", file=file, longitude=longitude, latitude=latitude, SST=SST, time=time) 
    rval
}

setMethod(f="plot",
          signature=signature("viirs"),
          definition=function(x, which="temperature", decimate=FALSE,
                              zlim, col=oce.colorsPalette,
                              coastline=coastlineWorld, # or NULL to turn off, or another coastline
                              debug=getOption("oceDebug"), ...) # early code
          {
              oceDebug(debug, "plot,landsat-method(..., which=c(", paste(which, collapse=","),
                       "), decimate=", decimate,
                       ", zlim=", if(missing(zlim)) "(missing)" else zlim,
                       ", ...) {\n", sep="", unindent=1)
              if (missing(zlim))
                  zlim <- range(x@data$SST, na.rm=TRUE)
              asp <- abs(1 / cos(pi * mean(range(x@data$latitude, na.rm=TRUE)) / 180))
              imagep(x@data$longitude, x@data$latitude, x@data$SST, zlim=zlim, col=col, decimate=decimate, asp=asp)
              if (!is.null(coastline)) {
                  if (is.logical(coastline) && coastline) {
                      data(coastlineWorld)
                      polygon(coastlineWorld[["longitude"]], coastlineWorld[["latitude"]], col="lightgray")
                  } else {
                      polygon(coastline[["longitude"]], coastline[["latitude"]], col="lightgray")
                  }
              }
          })
## }
## >>> This block could go into oce

if (0 == length(ls(pattern="^ig$"))) { # cache
    i <- read.viirs("~/Downloads/GMTCO-VSSTO_npp_d20160920_t0320078_e0325482_b25378_c20160924115556098849_noaa_ops.h5")
    ig <- viirsGrid(i)
}

if (!interactive()) png("1089c.png", width=800)
par(mar=c(3, 3, 1, 1))

data(coastlineWorldMedium, package="ocedata")
plot(ig, coastline=coastlineWorldMedium, col=oceColorsJet, zlim=c(10,30))
mtext(sprintf("gridded to dlon=%.2f and dlat=%.2f",
              diff(ig[['longitude']])[1], diff(ig[['latitude']])[1]), side=3, line=0, adj=0)
mtext(ig[["time"]], side=3, line=0, adj=1)

if (!interactive()) dev.off()
