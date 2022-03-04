# 02dk.R: read.ctd.aml() initiial trial.  NEXT: PI test; document; insert into oce.
library(oce)
file <- "Custom.export.026043_2021-07-21_17-36-45.txt"
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
    # I 
    serialNumber <- getMetadataItem(lines, "SN")
    Date <- getMetadataItem(lines, "Date", numeric=FALSE)
    Time <- getMetadataItem(lines, "Time", numeric=FALSE)
    time <- as.POSIXct(paste(Date, Time), tz="UTC")
    col.names <- strsplit(lines[1], ",")[[1]]
    CommentsLine <- grep("^Comments=", lines)
    oceDebug(debug, "CommentsLine=", CommentsLine, "\n")
    data <- read.csv(text=lines, skip=CommentsLine+1, header=FALSE, col.names=col.names)
    T <- data[["Temperature..C."]]
    C <- data[["Conductivity..mS.cm."]]
    p <- swPressure(data[["Depth..m."]])
    S <- swSCTp(conductivity=C, temperature=T, pressure=p, conductivityUnit="mS/cm", eos="unesco")
    rval <- as.ctd(S, T, p, longitude=longitude, latitude=latitude,
        time=time, serialNumber=serialNumber)
    rval@metadata$filename <- filename
    oceDebug(debug, "} # read.ctd.aml() {\n", unindent=1, style="bold")
    rval
}

ctd <- read.ctd.aml(file)
summary(ctd)
if (!interactive()) png("02dk.png")
plot(ctd)
if (!interactive()) dev.off()
