library(oce)

#' Read CTD format in SSDA format
#'
#' [read.ctd.ssda()] reads CTD files in Sea & Sun Technology´s Standard Data
#' Acquisition (SSDA) format. Based on examination of a particular data
#' file, as opposed to documentation on the data format, the function is
#' somewhat preliminary, in the sense that header information is not scanned
#' fully, and some guesses have been made about the meanings of variables
#' and units.
#'
#' @return a [ctd-class] object.
#'
#' @param file a connection or a character string giving the name of the file to
#' load.
#'
#' @param debug an integer specifying whether debugging information is
#' to be printed during the processing. If nonzero, some information
#' is printed.
#'
#' @family functions that read ctd data
#'
#' @author Dan Kelley
read.ctd.ssda <- function(file, debug=getOption("oceDebug"))
{
    debug <- max(0L, as.integer(debug))
    if (missing(file))
        stop("missing file")
    if (is.character(file) && 0 == file.info(file)$size)
        stop("empty file")
    oceDebug(debug, "read.ctd.ssda(file=\"", file, "\") {\n", unindent=1)
    filename <- ""
    if (is.character(file)) {
        filename <- fullFilename(file)
        file <- file(file, "r")
        on.exit(close(file))
    }
    lines <- readLines(file)
    seek(file, 0L) # rewind so we can read from the source (faster than reading from text)
    dataStart <- grep("^Lines[ ]*:[ ]*[0-9]*$", lines)
    header <- lines[1L:dataStart]
    if (1 != length(dataStart))
        stop("cannot find 'Lines :' in the data file.")
    # how many lines might there be in between?
    dataNames <- strsplit(gsub("^;[ ]*", "", lines[dataStart+2L]), "[ ]+")[[1]]
    dataNamesOriginal <- dataNames
    # Use standard oce names for some things. (Thanks to Liam MacNeil for pointing these out.)
    # Order these by name in the file, for convenience.
    nameMapping <- list(
        oxygenSaturation="AO2_%",
        oxygenMg="AO2mg",
        oxygenMl="AO2ml",
        bottom="Boden",
        scan="Datasets",
        pressure="Druck",
        latitude="Lat",
        conductivity="Leitf",
        fluorescence="Licor",
        longitude="Long",
        oxygenVoltage="RawO2",
        salinity="SALIN",
        sigma="SIGMA",
        temperature="Temp.")
    for (name in names(nameMapping)) {
        nameInFile <- nameMapping[[name]]
        dataNames[dataNames == nameInFile] <- name
    }
    d <- read.table(file, skip=dataStart + 4, col.names=dataNames, header=FALSE)
    # Not sure on the "N" in latitude. We need docs to know what is possible
    # in the location strings.
    lon <- as.numeric(d$longitude[1])
    londeg <- floor(lon / 100)
    lonmin <- lon - londeg*100
    longitude <- londeg + lonmin / 60.0
    oceDebug(debug, "lon=", lon, " deg=", londeg, " min=", lonmin, " -> longitude=", longitude, "\n")
    lat <- as.numeric(gsub("N","",d$latitude[1]))
    latdeg <- floor(lat / 100)
    latmin <- lat - latdeg*100
    latitude <- latdeg + latmin / 60.0
    oceDebug(debug, "lat=", lat, " deg=", latdeg, " min=", latmin, " -> latitude=", latitude, "\n")
    ctd <- as.ctd(salinity=d$salinity, temperature=d$temperature, pressure=d$pressure,
        longitude=longitude, latitude=latitude)
    ctd@metadata$header <- header
    ctd@metadata$dataNamesOriginal <- nameMapping
    # Add non-standard data
    for (n in names(d)) {
        if (!n %in% c(c("salinity", "pressure", "temperature", "latitude", "longitude"))) {
            ctd <- oceSetData(ctd, n, d[[n]], note=NULL)
        }
    }
    # We add time, removing the components (which serve no purpose)
    if (all(c("IntDT", "IntDT.1") %in% names(d))) {
        time <- as.POSIXct(paste(d$IntDT, d$IntDT.1), "%d.%m.%Y %H:%M:%S", tz="UTC")
        ctd <- oceSetData(ctd, "time", time, note=NULL)
        ctd@data$IntDT <- NULL
        ctd@data$IntDT.1 <- NULL
    }
    # Handle some conversions and units
    if ("oxygenVoltage" %in% names(ctd@data)) {
        # file has in mV but oce uses V
        ctd@data$oxygenVoltage <- 0.001 * ctd@data$oxygenVoltage
        ctd@metadata$units$oxygenVoltage <- list(unit=expression(V), scale="")
    }
    if ("oxygenSaturation" %in% names(ctd@data))
        ctd@metadata$units$oxygenSaturation<- list(unit=expression(percent), scale="")
    if ("conductivity" %in% names(ctd@data))
        ctd@metadata$units$conductivity <- list(unit=expression(mS/cm), scale="")
    if ("sigma" %in% names(ctd@data))
        ctd@metadata$units$sigma <- list(unit=expression(kg/m^3), scale="")
    oceDebug(debug, "} # read.ctd.ssda()\n")
    ctd
}
d <- read.ctd.ssda("14190549.csv", debug=3)

head(d[["salinity"]]) # a check agaist the file
summary(d)
if (!interactive())
    png("1909a.png")
plot(d, span=3000)

## test time decoding
#df <- data.frame(time=d[["time"]], IntDT=d[["IntDT"]], IntDT.1=d[["IntDT.1"]])
#print(head(df), 3)

if (!interactive())
    dev.off()


