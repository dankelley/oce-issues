if (!interactive()) pdf("456c.pdf", pointsize=11)
library(oce)

rename <- function(names, patterns, replacement, debug=getOption("oceDebug"))
{
    for (pattern in patterns) {
        matches <- grep(pattern, names)
        if (1 == length(matches)) {
            oceDebug(debug, "match to pattern", pattern, "\n")
            names[matches[1]] <- replacement
            break
        }
    }
    names
}

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
    names <- rename(names, c(".*CTD_Temp.*", "[Tt]emperature"), "temperature", debug=debug-1)
    names <- rename(names, ".*Pres.*", "pressure", debug=debug-1)
    names <- rename(names, c(".*sal.*", "[Ss]alinity"), "salinity", debug=debug-1)
    names <- rename(names, ".O2.*", "oxygen", debug=debug-1)
    names <- rename(names, "^[Dd]epth.*", "depth", debug=debug-1)
    names <- rename(names, "^[Ll]atitude", "latitude", debug=debug-1)
    names <- rename(names, "^[Ll]ongitude", "longitude", debug=debug-1)
    names <- rename(names, "[Ss]tation", "station", debug=debug-1)
    oceDebug(debug, 'data names: c(\"', paste(names, sep='", "'), ")\n")

    nlines <- length(dataLines)
    data <- read.table(text=dataLines, header=FALSE, sep='\t', col.names=names, stringsAsFactors=FALSE)
    cruise <- as.character(data[1,1])
    ## break up into stations
    stationStart <- which(0 < nchar(data$station) & !is.na(data$station))
    nstation <- length(stationStart)
    if (nstation > 1)
        stationEnd <- c(stationStart[-1]-1, nlines)
    else
        stationEnd <- nlines
    ctd <- vector("list", nstation)
    for (i in 1:nstation) {
        oceDebug(debug, "station", i, "@", stationStart[i], ":", stationEnd[i], '\n')
        d <- data[stationStart[i]:stationEnd[i],]
        station <- as.character(d$station[1])
        latitude <- as.numeric(d$latitude[1])
        longitude <- as.numeric(d$longitude[1])
        pressure <- if ("pressure" %in% names) d$pressure else swPressure(d$depth, latitude=latitude)
        salinity <- d$salinity
        temperature <- d$temperature
        ctd[i] <- as.ctd(salinity=salinity, temperature=temperature, pressure=pressure,
                         oxygen=d$oxygen, longitude=longitude, latitude=latitude, station=station)
    }
    ctd                                # a list containing CTD profiles
}

ctdList <- read.ctd.odv("profile.odv", debug=0)
for (ctd in ctdList)
    plot(ctd)

if (!interactive()) dev.off()
