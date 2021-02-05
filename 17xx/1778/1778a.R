library(oce)
f <- "2007-019-055.ctd"
lines <- readLines(f, encoding="latin1")
endLine <- grep("^\\*END OF HEADER$", lines)
if (0 == length(endLine))
    stop("file \"", f, "\" does not contain an \"*END OF HEADER\" line")
headerLines <- lines[seq(1, endLine-1)]
# Location -- FIXME should be looking in blocks, not using regexps
lon0 <- strsplit(headerLines[grep("LONGITUDE", headerLines)], " +")[[1]]
longitude <- as.numeric(lon0[4]) + as.numeric(lon0[5])/60
if (lon0[6] == "W")
    longitude <- -longitude
lat0 <- strsplit(headerLines[grep("LATITUDE", headerLines)], " +")[[1]]
latitude <- as.numeric(lat0[4]) + as.numeric(lat0[5])/60
if (lon0[6] == "S")
    latitude <- -latitude
cat("location:", longitude, "E, ", latitude, "N\n")

tmp <- strsplit(headerLines[grep("START TIME", headerLines)], " +")[[1]]
startTime <- as.POSIXct(paste(tmp[6], tmp[7]), tz="UTC")

# Next is brittle, being framed on a number of spaces at the start.  It might
# be better to look for the string "TABLE: CHANNELS" and then skip some lines,
# but isn't that risky, too?  Who knows which elements of the format are fixed,
# and which might be variable?
n <- grep("^[ ]{6,7}[0-9]{1,2} [A-Z]", headerLines)
nameLines <- headerLines[n]
names <- gsub("^[ 1-9]*([^ ]*) .*$", "\\1", nameLines)
# Rename data.  This is done in a brittle way for now, just as a test
dataNamesOriginal <- names             # FIXME: oce would want this
names[names=="Pressure"] <- "pressure"
names[names=="Depth"] <- "depth"
names[names=="Temperature:Primary"] <- "temperature" # BUG: will not handle secondary data
names[names=="Salinity:T0:C0"] <- "salinity" # BUG: will not handle secondary data
# We could change some other names but this is enough for basic work, and we do
# not have documentation on the names anyway, so this is a bit of a fools game.

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
summary(ctd)
if (!interactive())
    png("1778a.png")
plot(ctd)
message("\n\nFIXME: read other columns, set original names, etc (see github)")

if (!interactive())
    dev.off()
