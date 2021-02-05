#' Read an IOS-formatted CTD file
#'
#' This is a preliminary version of a function intended to read a data-file format
#' employed at the Institution of Ocean Sciences, of the Department of Fisheries
#' and Oceans, Canada.  It requires that the `oce` package be installed.
#'
#' @param filename character value specifying the file name
#' @param missingValue numeric value that is to be converted to `NA`. The default
#' value is presently -99, but a future version may set the default to `NULL`, meaning
#' to infer it from the file.
#'
#' @examples
#' ctd <- read.ctd.ios("2007-019-055.ctd")
#' summary(ctd)
#' plot(ctd)
#'
#' @references
#' \url{https://catalogue.cioos.ca/dataset/ios_ctd_profiles}
#'
#' @author Dan Kelley
read.ctd.ios <- function(filename, missingValue=-99)
{
    if (!requireNamespace("oce"))
        stop("The 'oce' package must be installed for read.ctd.ios() to work")
    getBlock <- function(lines, blockName)
    {
        pattern <- paste0("^\\*", blockName, "$")
        blockStart <- grep(pattern, lines)
        n <- length(blockStart)
        if (n == 0)
            stop("This file does not have a block matching \"", pattern, "\"")
        if (n > 1)
            stop("This file has more than one block matching \"", pattern, "\"")
        blockEnd <- grep("^\\*", lines)
        blockEnd <- blockEnd[blockEnd > blockStart][1]
        lines[seq(blockStart, blockEnd-1L)]
    }

    lines <- readLines(filename, encoding="latin1")
    endLine <- grep("^\\*END OF HEADER$", lines)
    if (0 == length(endLine))
        stop("file \"", f, "\" does not contain an \"*END OF HEADER\" line")
    headerLines <- lines[seq(1, endLine-1)]
    # LOCATION block (longitude, latitude, station)
    locationBlock <- getBlock(headerLines, "LOCATION")
    tmp <- strsplit(locationBlock[grep("LONGITUDE", locationBlock)], " +")[[1]]
    longitude <- (as.numeric(tmp[4]) + as.numeric(tmp[5])/60) * ifelse(tmp[6] == "W", -1, 1)
    tmp <- strsplit(locationBlock[grep("LATITUDE", locationBlock)], " +")[[1]]
    latitude <- (as.numeric(tmp[4]) + as.numeric(tmp[5])/60) * ifelse(tmp[6] == "S", -1, 1)
    tmp <- strsplit(locationBlock[grep("STATION", locationBlock)], " +")[[1]]
    station <- tmp[4]
    # FILE block (time)
    fileBlock <- getBlock(headerLines, "FILE")
    tmp <- strsplit(fileBlock[grep("START TIME", fileBlock)], " +")[[1]]
    startTime <- as.POSIXct(paste(tmp[6], tmp[7]), tz="UTC")

    # Determine column names.  This is rudimentary, and brittle.
    # We need docs on the file format before finalizing this.
    n <- grep("^[ ]{6,7}[0-9]{1,2} [A-Z]", fileBlock)
    nameLines <- fileBlock[n]
    names <- gsub("^[ 1-9]*([^ ]*) .*$", "\\1", nameLines)
    # Rename data.  This is done in a brittle way for now, just as a test
    dataNamesOriginal <- list()
    names[names=="Pressure"] <- "pressure"
    dataNamesOriginal$pressure <- "Pressure"
    names[names=="Depth"] <- "depth"
    dataNamesOriginal$depth <- "Depth"
    names[names=="Temperature:Primary"] <- "temperature" # BUG: will not handle secondary data
    dataNamesOriginal$temperature <- "Temperature:Primary"
    names[names=="Salinity:T0:C0"] <- "salinity" # BUG: will not handle secondary data
    dataNamesOriginal$salinity <- "Salinity:T0:C0"
    # We could change some other names but this is enough for a test file, and we do
    # not have documentation on the names anyway, so this is a bit of a fool's game.

    dataLines <- lines[seq(endLine+1, length(lines))]
    data <- read.table(filename, skip=1 + endLine)
    if (dim(data)[2] != length(names))
        stop("cannot determine column names. dim(d)[2] is ", dim(d)[2], " but # of names is ", length(names))
    colnames(data) <- names
    if (3 != sum(c("salinity", "temperature", "pressure") %in% names(data)))
        warning("dataset does not contain all of: salinity, temperature, and data")
    res <- oce::as.ctd(data)
    res <- oce::oceSetMetadata(res, "longitude", longitude)
    res <- oce::oceSetMetadata(res, "latitude", latitude)
    res <- oce::oceSetMetadata(res, "startTime", startTime)
    res <- oce::oceSetMetadata(res, "station", station)
    res <- oce::oceSetMetadata(res, "dataNamesOriginal", dataNamesOriginal)
    res
}

