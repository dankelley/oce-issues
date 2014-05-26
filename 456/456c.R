if (!interactive()) pdf("456c_%d.pdf", pointsize=9)
library(oce)
read.ctd.odv <- function(file, columns=NULL, station=NULL, missing.value,
                         monitor=FALSE, debug=getOption("oceDebug"), processingLog, ...)
{
    if (!missing(columns)) warning("read.ctd.odv ignores columns for now\n")
    if (!missing(station)) warning("read.ctd.odv ignores station for now\n")
    if (!missing(missing.value)) warning("read.ctd.odv ignores missing.value for now\n")
    lines <- readLines(file, warn=FALSE)
    nlines <- length(lines)
    headerLines <- lines[grep("^//", lines)]
    dataStart <- grep("^Cruise", lines)
    if (0 == length(dataStart))
        stop("Cannot find a line starting with 'Cruise' in data file")
    dataLines <- lines[seq.int(dataStart+1, nlines)]
    names <- strsplit(lines[dataStart], '\t')[[1]]
    rename <- function(names, name, alt) {
        for (a in alt) {
            if (a %in% names) {
                names[which(a == names)] <- name
                break
            }
        }
        names
    }
    names <- rename(names, "Temperature", "Cal_CTD_Temp [degC]")
    names <- rename(names, "Pressure", "Pres_Z [dbar]")
    names <- rename(names, "Salinity", "P_sal_CTD_calib [Dmnless]")
    names <- rename(names, "Oxygen", "WC_dissO2_uncalib [umol/l]")
    if (1==length(grep("^Depth", names))) names[grep("^Depth", names)] <- "Depth"
    if (1==length(grep("^Latitude", names))) names[grep("^Latitude", names)] <- "Latitude"
    if (1==length(grep("^Longitude", names))) names[grep("^Longitude", names)] <- "Longitude"
    oceDebug(debug, 'data names: c(\"', paste(names, sep='", "'), ")\n")

    nlines <- length(dataLines)
    data <- read.table(text=dataLines, header=FALSE, sep='\t', col.names=names, stringsAsFactors=FALSE)
    cruise <- as.character(data[1,1])
    ## break up into stations
    stationStart <- which(0 < nchar(data$Station))
    nstation <- length(stationStart)
    if (nstation > 1)
        stationEnd <- c(stationStart[-1]-1, nlines)
    else
        stationEnd <- nlines
    ctd <- vector("list", nstation)
    for (i in 1:nstation) {
        oceDebug(debug, "station", i, "@", stationStart[i], ":", stationEnd[i], '\n')
        d <- data[stationStart[i]:stationEnd[i],]
        station <- as.character(d$Station[1])
        latitude <- as.numeric(d$Latitude[1])
        longitude <- as.numeric(d$Longitude[1])
        pressure <- if ("Pressure" %in% names) d$Pressure else swPressure(d$Depth, latitude=latitude)
        salinity <- d$Salinity
        temperature <- d$Temperature
        ctd[i] <- as.ctd(salinity=salinity, temperature=temperature, pressure=pressure,
                         oxygen=d$Oxygen,
                         longitude=longitude, latitude=latitude, station=station)
    }
    ctd                                # a list containing CTD profiles
}

ctdList <- read.ctd.odv("data/1081226_20140521_002009.txt", debug=0)
for (ctd in ctdList)
plot(ctd)

if (!interactive()) dev.off()
