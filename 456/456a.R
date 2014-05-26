if (!interactive()) pdf("456a_%d.pdf")
library(oce)
# http://www.seadatanet.org/content/download/9752/65735/file/Examples%20of%20SeaDataNet%20variant%20ODV%20spreadsheet-based%20import%20format.xls
file <- "profile.odv"
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
    str(d)
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
section <- makeSection(ctd)
plot(section[["station", 1]])
plot(section[["station", 2]])

if (!interactive()) dev.off()
