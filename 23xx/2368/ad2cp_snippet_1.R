# export a single bottom-track record so I can examine it carefully.
library(oce)
debug <- 1

sf <- "snippet.ad2cp" # snippet holding just a bottom-track record

file <- "/Users/kelley/Downloads/S102791A003_Barrow_2022_0001_sub.ad2cp" # Clark's file
cat("file=", file, "\n", sep = "")
buf <- readBin(file, "raw", endian = "little", n = file.size(file))

# nav is a list with vectors start, index, headerLength, dataLength, id, along
# with scalars checksumFailures and earlyEOF.
nav <- oce:::do_ldc_ad2cp_in_file(file, from = 1L, to = 1e9, by = 1L, debug = debug)
sum(nav$id == 0x17) # [1] 3540
w <- which(nav$id == 0x17)
focus <- 2000
nav$index[w[focus]] # 5907083
extractStart <- nav$index[w[focus]] - 9
headerSize <- as.integer(buf[extractStart + 1])
stopifnot(10 == headerSize)
id <- buf[extractStart + 2]
stopifnot(0x17 == id)
stopifnot(0x10 == buf[extractStart + 3]) # always 0x10 for AD2CP
dataSize <- readBin(buf[extractStart + 4:5], "integer", size = 2, n = 1, endian = "little")
stopifnot(118 == dataSize)
extractEnd <- extractStart + dataSize + (headerSize - 1)
stopifnot(0xa5 == buf[extractEnd + 1])
extract <- buf[extractStart:extractEnd]
header <- extract[1:10]

# Phase 2 decode it, byte by byte.  (I know, I wrote this already,
# in a different form, but the idea here is to start from scratch
# and see why the inferred velocities are wrong.)

#<OLD> offsetOfData <- as.integer(buf[extractStart + headerSize + 1]) # 78
offsetOfData <- as.integer(extract[headerSize + 2])
stopifnot(78 == offsetOfData)
oceDebug(debug, vectorShow(offsetOfData))

# Analyse 2-byte Configuration block for Bottom-Track data (I think it differs for othes)
dataAvailableBottomTrack <- function(twoBytes) {
    configuration <- ifelse(rawToBits(twoBytes) == 0x01, TRUE, FALSE)
    valid <- list()
    valid$pressure <- configuration[1] # NOTE: Nortek code calls this bit 0, etc for rest
    valid$temperature <- configuration[2]
    valid$compass <- configuration[3]
    valid$tilt <- configuration[4]
    # bit 5 (called bit 4 in Nortek code) is empty
    valid$velocity <- configuration[6]
    valid$amplitude <- configuration[7]
    valid$correlation <- configuration[8]
    valid$distance <- configuration[9]
    valid$figureOfMerit <- configuration[10]
    valid$AHRS <- configuration[11]
    valid$aux <- configuration[12]
    valid
}
dataAvailable <- dataAvailableBottomTrack(extract[headerSize + 3:4])
oceDebug(debug, vectorShow(dataAvailable))
stopifnot(dataAvailable$velocity & dataAvailable$distance & dataAvailable$figureOfMerit)

pressure <- 0.001 * readBin(extract[headerSize + 21:24], "integer", size = 4L, endian = "little")
oceDebug(debug, vectorShow(pressure))


cat("extract:\n")
extract

cat("header:\n")
header

record <- extract[headerSize + 1:length(extract)]
cat("record:\n")
record

data <- extract[offsetOfData:length(extract)] # FIXME is start right, or +1 or -1?
cat("data:\n")
data
data[1:4]

fac <- 1e-3 # mm/s
data[1:4]
fac * readBin(data[1:4], "integer", size = 4, n = 1, endian = "little")
data[4 + 1:4]
fac * readBin(data[4 + 1:4], "integer", size = 4, n = 1, endian = "little")
data[8 + 1:4]
fac * readBin(data[8 + 1:4], "integer", size = 4, n = 1, endian = "little")
data[12 + 1:4]
fac * readBin(data[12 + 1:4], "integer", size = 4, n = 1, endian = "little")
