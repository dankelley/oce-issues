if (!interactive()) pdf("456b.pdf")
library(oce)
## http://www.seadatanet.org/content/download/9752/65735/file/Examples%20of%20SeaDataNet%20variant%20ODV%20spreadsheet-based%20import%20format.xls
read.ctd.odv <- function(file, columns=NULL, station=NULL, missing.value,
                         monitor=FALSE, debug=getOption("oceDebug"), processingLog, ...)
{
    if (!missing(columns)) warning("read.ctd.odv ignores columns for now\n")
    if (!missing(station)) warning("read.ctd.odv ignores station for now\n")
    if (!missing(missing.value)) warning("read.ctd.odv ignores missing.value for now\n")
    lines <- readLines(file)
    headerLines <- grep("^//", lines)
    header <- lines[headerLines]
    lines <- lines[-headerLines]
    names <- strsplit(lines[1], '\t')[[1]]
    if (1==length(grep("^Oxygen", names))) names[grep("^Oxygen", names)] <- "Oxygen"
    if (1==length(grep("^Temperature", names))) names[grep("^Temperature", names)] <- "Temperature"
    if (1==length(grep("^Salinity", names))) names[grep("^Salinity", names)] <- "Salinity"
    if (1==length(grep("^Depth", names))) names[grep("^Depth", names)] <- "Depth"
    if (1==length(grep("^Latitude", names))) names[grep("^Latitude", names)] <- "Latitude"
    if (1==length(grep("^Longitude", names))) names[grep("^Longitude", names)] <- "Longitude"

    lines <- lines[-1]
    nlines <- length(lines)
    data <- read.table(text=lines, header=FALSE, sep='\t', col.names=names)
    cruise <- as.character(data[1,1])
    ## break up into stations
    stationStart <- which(!is.na(data$Station))
    nstation <- length(stationStart)
    stationEnd <- c(stationStart[-1]-1, nlines)
    ctd <- vector("list", nstation)
    for (i in 1:nstation) {
        ## cat("station", stationStart[i], ":", stationEnd[i], '\n')
        d <- data[stationStart[i]:stationEnd[i],]
        station <- as.character(d$Station[1])
        latitude <- as.numeric(d$Latitude[1])
        longitude <- as.numeric(d$Longitude[1])
        pressure <- swPressure(d$Depth, latitude=latitude)
        salinity <- d$Salinity
        temperature <- d$Temperature
        ctd[i] <- as.ctd(salinity=salinity, temperature=temperature, pressure=pressure,
                         oxygen=d$Oxygen,
                         longitude=longitude, latitude=latitude, station=station)
    }
    ctd                                # a list containing CTD profiles
}

ctdList <- read.ctd.odv("profile.odv")
plot(ctdList[[1]])
plot(ctdList[[2]])

## section <- makeSection(ctdList)
## plot(section)

if (!interactive()) dev.off()
