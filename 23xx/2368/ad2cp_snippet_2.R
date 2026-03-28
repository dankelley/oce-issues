# export a single bottom-track record so I can examine it carefully.
library(oce)
source("adp.nortek.ad2cp.bottom.track.R")
debug <- 1

sf <- "snippet.ad2cp" # snippet holding just a bottom-track record
buf <- readBin(sf, "raw", endian = "little", n = file.size(sf))
offset <- 0
stopifnot(buf[1 + offset] == 0xa5)
headerLength <- buf[2 + offset]
stopifnot(10 == headerLength)
id <- buf[3 + offset]
stopifnot(0x17 == id)

configuration <- ifelse(strsplit(byteToBinary(buf[3:4 + offset]), "")[[1]] == "0", 0, 1)
oceDebug(debug, "Configuration: ", paste(configuration, collapse=" "), "\n")

# {{{ configuration
pressureIncluded <- configuration[1] # NOTE: Nortek code calls this bit 0, etc for rest
temperatureIncluded <- configuration[2]
compassIncluded <- configuration[3]
tiltIncluded <- configuration[4]
# bit 5 (called bit 4 in Nortek code) is empty
velocityIncluded <- configuration[6]
amplitudeIncluded <- configuration[7]
correlationIncluded <- configuration[8]
distanceIncluded <- configuration[9]
figureOfMeritIncluded <- configuration[10]
AHRSIncluded <- configuration[11]
auxIncluded <- configuration[12]
# Last 4 bits of this 16-bit cluster are ignored
oceDebug(debug, "Analysis of 'configuration' bits, proceeding left-to-right:\n")
oceDebug(debug, "  ", vectorShow(pressureIncluded, postscript = "based on configuration[1]"))
oceDebug(debug, "  ", vectorShow(temperatureIncluded, postscript = "based on configuration[2]"))
oceDebug(debug, "  ", vectorShow(compassIncluded, postscript = "based on configuration[3]"))
oceDebug(debug, "  ", vectorShow(tiltIncluded, postscript = "based on configuration[4]"))
oceDebug(debug, "  ", vectorShow(velocityIncluded, postscript = "based on configuration[6]"))
oceDebug(debug, "  ", vectorShow(amplitudeIncluded, postscript = "based on configuration[7]"))
oceDebug(debug, "  ", vectorShow(correlationIncluded, postscript = "based on configuration[8]"))
oceDebug(debug, "  ", vectorShow(distanceIncluded, postscript = "based on configuration[9]"))
oceDebug(debug, "  ", vectorShow(figureOfMeritIncluded, postscript = "based on configuration[10]"))
oceDebug(debug, "  ", vectorShow(AHRSIncluded, postscript = "based on configuration[11]"))
oceDebug(debug, "  ", vectorShow(auxIncluded, postscript = "based on configuration[12]"))

# }}}
offsetOfData <- as.integer(buf[12 + offset]) # 78

dbuf <- buf[78:length(buf)] # 51 bytes
readBin(dbuf[1:4], "integer", size = 4, n = 1, endian = "little")
readBin(dbuf[4 + 1:4], "integer", size = 4, n = 1, endian = "little")
readBin(dbuf[8 + 1:4], "integer", size = 4, n = 1, endian = "little")
readBin(dbuf[12 + 1:4], "integer", size = 4, n = 1, endian = "little")


d <- list(buf = buf, index = 1, headerLength = headerLength, dataLength = NA, id = id)

# commonData$configuration <- local({
#    tmp <- rawToBits(d$buf[pointer2 + 3L]) == 0x01
#    dim(tmp) <- c(16, N)
#    t(tmp)
# })



readBottomTrackNEW(d, 1)

# d <- list(buf = buf, index = nav$index, headerLength = nav$headerLength, dataLength = nav$dataLength, id = nav$id)
