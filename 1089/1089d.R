library(oce)

## This block could go into oce <<<
setClass("viirs", contains="satellite")
setMethod(f="initialize",
          signature="viirs",
          definition=function(.Object, file) {
              .Object@metadata$file <- if (missing(file)) "?" else file
              .Object@processingLog$time <- as.POSIXct(Sys.time())
              .Object@processingLog$value <- "create 'viirs' object"
              .Object@metadata$dataNamesOriginal <- list()
              return(.Object)
          })

viirsGrid <- function(viirs, decimate=4, fillgap=0, smooth=TRUE)
{
    if (!is.matrix(viirs@data$longitude)) {
        warning("already gridded")
        return(viirs)
    }
    if (length(decimate) == 1)
        decimate <- rep(decimate, 2)
    res <- viirs # will change in-place
    bands <- names(viirs@data)
    bands <- bands[bands != "longitude"]
    bands <- bands[bands != "latitude"]
    if (length(bands) == 0)
        stop("no bands to grid")
    longitude <- viirs[["longitude"]]
    latitude <- viirs[["latitude"]]
    dimOriginal <- dim(viirs@data[[1]])
    lonG <- pretty(longitude, n=dimOriginal[1]/decimate[1])
    latG <- pretty(latitude, n=dimOriginal[2]/decimate[2])
    for (band in bands) {
        message("gridding band '", band, "' with fillgap=", fillgap)
        G <- if (fillgap <= 0) binMean2D(longitude, latitude, viirs[[band]], lonG, latG)
            else binMean2D(longitude, latitude, viirs[[band]], lonG, latG, fill=TRUE, fillgap=fillgap)
        for (pass in seq_len(smooth))
            G$result <- matrixSmooth(G$result)
        res@data[[band]] <- G$result
    }
    res@data$longitude <- G$xmids
    res@data$latitude <- G$ymids
    res@processingLog <- processingLogAppend(res@processingLog,
                                             paste(deparse(match.call()), sep="", collapse=""))
    res
}

read.viirs <- function(file, band="SST")
{
    if (!require(rhdf5))
        stop("must install 'rhd5' package for read.viirs to work. Do as follows: source(\"https://bioconductor.org/biocLite.R\") biocLite(\"rhdf5\") ")
    res <- new("viirs", file=file)
    dir <- h5ls(file, all=TRUE)
    ##
    ## 1. metadata slot
    res@metadata$dir <- dir
    res@metadata$SSTfactors <- h5read(file, "All_Data/VIIRS-SST-EDR_All/SkinSSTFactors")

    ## Time is a vector (length 192) and I don't know what that means, so I just
    ## take a mean value.  The units are weird; see page 307 of viirs-sdr-dataformat.pdf
    owarn <- options('warn')$warn # quieten a warning msg
    options(warn=-1)
    MidTime <- h5read(file, "All_Data/VIIRS-MOD-GEO-TC_All/MidTime", bit64conversion="double")
    options(warn=owarn)
    res@metadata$time <- as.POSIXct("1958-01-01 00:00:00", tz="UTC") + mean(MidTime/1e6)
    ##
    ## 2. data slot
    ## Lon and lat are straightforwd
    res@data$longitude <- h5read(file, "All_Data/VIIRS-MOD-GEO-TC_All/Longitude")
    res@metadata$dataNamesOriginal$longitude <- "Longitude"
    res@data$latitude <- h5read(file, "All_Data/VIIRS-MOD-GEO-TC_All/Latitude")
    res@metadata$dataNamesOriginal$latitude <- "Latitude"

    res@metadata$bulkSkinOffset <- h5read(file, "All_Data/VIIRS-SST-EDR_All/Bulk-Skin_Offset")[1] # FIXME: why 4 long??
    ## Guessing on the unit of SST. The docs suggest maybe Kelvin, but a 
    ## hist() of 'SST' computed next looks (a bit) more oceanographic.
    ## I emailed someone to find out what the true format is.
    if ("SST" %in% band) {
        SST <- h5read(file, "All_Data/VIIRS-SST-EDR_All/SkinSST")
        ## NA codes are given in Table 7, on page 8, of
        ## https://jointmission.gsfc.nasa.gov/sciencedocs/2015-06/474-00061_OAD-VIIRS-SST-EDR_D.pdf
        ## bad <- SST == 65535 | SST == 65534 | SST == 65531 
        bad <- SST > 2^16 - 10 # otherwise clearly includes bad data
        SST[bad] <- NA
        SST <- res@metadata$SSTfactors[1] * SST + res@metadata$SSTfactors[2] - 273.15
        ## the offset is 0.17degC so I'm not too worried about it
        res@data$SST <- SST # + res@metadata$bulkSkinOffset
        res@metadata$dataNamesOriginal$SST <- "SkinSST"
        res@processingLog <- processingLogAppend(res@processingLog, "add SST")
    }

    if ("SSTref" %in% band) {
        SSTref <- h5read(file, "All_Data/VIIRS-SST-EDR_All/ReferenceSST")
        bad <- SSTref > 2^16-1 - 10 # top two values seem to be NA codes
        SSTref[bad] <- NA
        ## Q: are their specialized factors for SSTref?
        SSTref <- res@metadata$SSTfactors[1] * SSTref + res@metadata$SSTfactors[2] - 273.15
        res@data$SSTref <- SSTref
        res@metadata$dataNamesOriginal$SSTref <- "ReferenceSST"
        res@processingLog <- processingLogAppend(res@processingLog, "add SSTref")
    }

    if ("chlorophylla" %in% band) {
        chlorophylla <- h5read(file, "All_Data/VIIRS-OCC-EDR_All/Chlorophyll_a")
        bad <- chlorophylla < (-999) # code is -999.3 but cannot match with floating-point
        chlorophylla[bad] <- NA
        res@data$chlorophylla <- chlorophylla
        res@metadata$dataNamesOriginal$chlorophylla <- "Chlorophyll_a"
        res@processingLog <- processingLogAppend(res@processingLog, "add chlorophylla")
    }
    res
}

setMethod(f="plot",
          signature=signature("viirs"),
          definition=function(x, band="SST", decimate=FALSE,
                              zlim, col=oce.colorsPalette,
                              log=FALSE,
                              coastline=coastlineWorld, # or NULL to turn off, or another coastline
                              debug=getOption("oceDebug"), ...) # early code
          {
              debug <- 3
              oceDebug(debug, "plot,landsat-method(..., band=c(", paste(band, collapse=","),
                       "), decimate=", decimate,
                       ", zlim=", if(missing(zlim)) "(missing)" else zlim,
                       ", ...) {\n", sep="", unindent=1)
              owarn <- options("warn")$warn
              options(warn=-1)
              data <- x@data[[band]]
              if (log)
                  data <- log10(data)
              if (missing(zlim))
                  zlim <- range(data, na.rm=TRUE, finite=TRUE)
              options(warn=owarn)
              asp <- abs(1 / cos(pi * mean(range(x@data$latitude, na.rm=TRUE)) / 180))
              if (missing(zlim))
                  zlim <- range(x@data[[band]], na.rm=TRUE)
              if (sum(!is.na(data))) {
                  imagep(x@data$longitude, x@data$latitude, data, zlim=zlim, col=col, decimate=decimate, asp=asp, ...)
              } else {
                  plot(range(x@data$longitude), range(x@data$latitude), type='n', xlab="", ylab="", asp=asp, ...)
                  text(mean(x@data$longitude), mean(x@data$latitude), "no\ngood\ndata", font=2)
              }
              if (!is.null(coastline)) {
                  if (is.logical(coastline) && coastline) {
                      data(coastlineWorld)
                      polygon(coastlineWorld[["longitude"]], coastlineWorld[["latitude"]], col="lightgray")
                  } else {
                      polygon(coastline[["longitude"]], coastline[["latitude"]], col="lightgray")
                  }
              }
              names <- list(SST="SST [degC]", chlorophylla="log10(Chlorophyll A)")
              mtext(names[band], side=3, line=0.25, adj=1)
          })
## }
## >>> This block could go into oce


## some NS images (?) maybe ascending+descending, SST + chlor
files <- "~/Dropbox/GMTCO-VOCCO-VSSTO_npp_d20160924_t1657456_e1703260_b25443_c20160927173359271877_noaa_ops.h5"

if (!interactive())
    png("1089d.png",
        width=7, height=3, unit="in", res=200, pointsize=9, type='cairo')
par(mfrow=c(1,2))

data(coastlineWorldMedium, package="ocedata")
filledContour <- FALSE
for (ifile in seq_along(files)) {
    i <- read.viirs(files[ifile], band=c("SST", "chlorophylla"))
    lat0 <- mean(range(i[["latitude"]]))
    decimate <- c(15, 30)
    ig <- viirsGrid(i, decimate, fillgap=0, smooth=0)
    plot(ig, band="SST", coastline=coastlineWorldMedium, col=oceColorsJet,
         xlim=c(-80, -50), ylim=c(35, 50), filledContour=filledContour)
    mtext(ig[["time"]], side=3, line=0.25, adj=0)
    plot(ig, band="chlorophylla", log=TRUE,
         coastline=coastlineWorldMedium, col=oceColorsJet, zlim=c(-2, 4),
         xlim=c(-80, -50), ylim=c(35, 50), filledContour=filledContour)
}

if (!interactive()) dev.off()

