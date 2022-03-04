# 02dk.R: read.ctd.aml() initiial trial.  NEXT: PI test; document; insert into oce.
library(oce)

#' Read an AML CTD file
#'
#' This function CTD "txt" formatted data from an AML Oceanographic BaseX2 instrument.
#' It is in a preliminary form, based on just a single data file, and without
#' guidance from any manufacturer's documentation on the format; see \dQuote{Details}.
#'
#' [read.ctd.aml()] makes assumptions about the data columns
#' that might not be true for all files. For example, it assumes that
#' depth is presented, not pressure, and that the unit is metres.
#' Similarly, it assumes that conductivity is present, not salinity, and that
#' the unit is mS/cm.
#'
#' Assumptions are also made about the metadata.  For example, the supplied
#' test file had two entries for Longitude, and two for Latitude, which
#' perhaps relate to starting and ending locations, but only the first location
#' is stored by [read.ctd.aml()].  The time is assumed to be in UTC. Just a single
#' serial number is scanned from the file, because it (named 'SN' in the file)
#' seems to refer to the instrument as a whole.
#'
#' Future versions of this function might behave differently on the above
#' inferences, if the author is provided with more definitive information
#' about the file format.  Also, the files contain much more metadata than
#' is read by this function, and items could be added quite easily, if
#' users express a need for them.
#'
#' @param file a connection or a character string giving the name of the file to
#' load.  This must be in the "txt" format, not the "csv" format.
#'
#' @template debugTemplate
#'
#' @return a [ctd-class] object.
#'
#' @author Dan Kelley
#'
#' @family functions that read ctd data
read.ctd.aml <- function(file, debug=getOption("oceDebug"))
{
    oceDebug(debug, "read.ctd.aml() {\n", unindent=1, style="bold")
    if (!missing(file) && is.character(file) && 0 == file.info(file)$size)
        stop("empty file")
    filename <- ""
    if (is.character(file)) {
        filename <- fullFilename(file)
        file <- file(file, "r")
        on.exit(close(file))
    }
    if (!inherits(file, "connection"))
        stop("argument `file' must be a character string or connection")
    if (!isOpen(file)) {
        open(file, "r")
        on.exit(close(file))
    }
    getMetadataItem <- function(lines, name, numeric=TRUE)
    {
        l <- grep(paste0("^",name,"="), lines)
        if (length(l) > 0L) {
            # NOTE: we take first definition, ignoring others
            item <- lines[l[1]]
            res <- strsplit(lines[l], "=")[[1]][2]
            if (numeric)
                res <- as.numeric(res)
            else
                res <- trimws(res)
        } else {
            NULL
        }
        res
    }
    lines <- readLines(file, encoding="UTF-8-BOM", warn=FALSE)
    # FIXME: add other relevant metadata here.  This will require some
    # familiarity with the typical contents of the metadata.  For example,
    # I see 'SN' and 'BoardSN', and am inferring that we want to save
    # the first, but maybe it's the second...
    longitude <- getMetadataItem(lines, "Longitude")
    latitude <- getMetadataItem(lines, "Latitude")
    serialNumber <- getMetadataItem(lines, "SN")
    Date <- getMetadataItem(lines, "Date", numeric=FALSE)
    Time <- getMetadataItem(lines, "Time", numeric=FALSE)
    time <- as.POSIXct(paste(Date, Time), tz="UTC")
    col.names <- strsplit(lines[1], ",")[[1]]
    CommentsLine <- grep("^Comments=", lines)
    oceDebug(debug, "CommentsLine=", CommentsLine, "\n")
    header <- lines[seq(1L, CommentsLine-1L)]
    data <- read.csv(text=lines, skip=CommentsLine+1, header=FALSE, col.names=col.names)
    T <- data[["Temperature..C."]]
    C <- data[["Conductivity..mS.cm."]]
    p <- swPressure(data[["Depth..m."]])
    S <- swSCTp(conductivity=C, temperature=T, pressure=p, conductivityUnit="mS/cm", eos="unesco")
    rval <- as.ctd(S, T, p, longitude=longitude, latitude=latitude,
        time=time, serialNumber=serialNumber)
    rval@metadata$filename <- filename
    rval@metadata$header <- header
    oceDebug(debug, "} # read.ctd.aml() {\n", unindent=1, style="bold")
    rval
}

file <- "Custom.export.026043_2021-07-21_17-36-45.txt"
ctd <- read.ctd.aml(file)
summary(ctd)
if (!interactive()) png("04dk.png")
plot(ctd)
if (!interactive()) dev.off()
