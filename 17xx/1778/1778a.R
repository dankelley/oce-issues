library(oce)
f <- "2007-019-055.ctd"

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

lines <- readLines(f, encoding="latin1")
endLine <- grep("^\\*END OF HEADER$", lines)
if (0 == length(endLine))
    stop("file \"", f, "\" does not contain an \"*END OF HEADER\" line")
headerLines <- lines[seq(1, endLine-1)]
# Location
locationBlock <- getBlock(headerLines, "LOCATION")
tmp <- strsplit(locationBlock[grep("LONGITUDE", locationBlock)], " +")[[1]]
longitude <- (as.numeric(tmp[4]) + as.numeric(tmp[5])/60) * ifelse(tmp[6] == "W", -1, 1)
tmp <- strsplit(locationBlock[grep("LATITUDE", locationBlock)], " +")[[1]]
latitude <- (as.numeric(tmp[4]) + as.numeric(tmp[5])/60) * ifelse(tmp[6] == "S", -1, 1)
tmp <- strsplit(locationBlock[grep("STATION", locationBlock)], " +")[[1]]
station <- tmp[4]

# Time
fileBlock <- getBlock(headerLines, "FILE")
tmp <- strsplit(fileBlock[grep("START TIME", fileBlock)], " +")[[1]]
startTime <- as.POSIXct(paste(tmp[6], tmp[7]), tz="UTC")

# Next is brittle, being framed on a number of spaces at the start.  It would
# be better to look for the string "TABLE: CHANNELS" and then skip some lines,
# but that could be risky too, since we DO NOT KNOW the format, and so any
# guess might be okay for one file and bad for another.
n <- grep("^[ ]{6,7}[0-9]{1,2} [A-Z]", fileBlock)
nameLines <- fileBlock[n]
names <- gsub("^[ 1-9]*([^ ]*) .*$", "\\1", nameLines)
# Rename data.  This is done in a brittle way for now, just as a test
dataNamesOriginal <- names             # FIXME: oce would want this
names[names=="Pressure"] <- "pressure"
names[names=="Depth"] <- "depth"
names[names=="Temperature:Primary"] <- "temperature" # BUG: will not handle secondary data
names[names=="Salinity:T0:C0"] <- "salinity" # BUG: will not handle secondary data
# We could change some other names but this is enough for a test file, and we do
# not have documentation on the names anyway, so this is a bit of a fool's game.

dataLines <- lines[seq(endLine+1, length(lines))]
d <- read.table(f, skip=1 + endLine)
if (dim(d)[2] != length(names))
    stop("cannot determine column names. dim(d)[2] is ", dim(d)[2], " but # of names is ", length(names))
colnames(d) <- names

# BUG: next should work, but it does not record the lon and lat
# ctd <- as.ctd(d, longitude=longitude, latitude=latitude)
ctd <- as.ctd(d)
ctd <- oceSetData(ctd, "longitude", longitude)
ctd <- oceSetData(ctd, "latitude", latitude)
ctd <- oceSetMetadata(ctd, "startTime", startTime)
ctd <- oceSetMetadata(ctd, "station", station)
summary(ctd)

if (!interactive()) png("1778a.png")
plot(ctd)
if (!interactive()) dev.off()

