rm(list = ls())
# GOAL: Try to read an RDI file containing wave data.
#
# NOTES: The idea is to look in R, before writing C++ code.  I see
# NOTHING in the documentation about where checksums are in the data
# (although the docs say that the files contain checksums) and the
# ending of a 'firstLeader' record is not what I expected. Until I
# learn more, this test is blocked from progress.

library(oce)
f <- "~/Downloads/oce2216.000"
nbytes <- file.size(f)
buf <- readBin(f, "raw", n = nbytes / 10)
if (FALSE) {
    # examine 0x03 0x02 pairs
    a03 <- which(buf == 0x03)
    a02 <- which(buf == 0x02)
    OK <- sapply(a03, \(i) buf[i + 1] == 0x02)
    pingStart <- a03[OK]
    cat("wave ping type ... summary(diff(pingStart)) is\n")
    print(summary(diff(pingStart)))
}

debug <- 0
readHeader <- function(buf, i, debug = 0) {
    if (debug > 0) cat("readHeader(buf, i=", i, ") -- wavemon sec 4.5 table 16\n", sep = "")
    i0 <- i
    if (buf[i0] != 0x7f || buf[i0 + 1] != 0x79) {
        warning("first 2 bytes are not 0x7f ox79", .immediate = TRUE)
        return(list(type = "error"))
    } else {
        rval <- list(type = "header")
        i0 <- i
        i <- i + 2
        rval$checksumOffset <- readBin(buf[i0 + 3:4], "integer", n = 1, size = 2, signed = FALSE)
        # cat(" ", vectorShow(checksumOffset))
        i <- i + 2
        rval$spare <- buf[i]
        # cat(" ", vectorShow(spare))
        i <- i + 1
        rval$numberOfDataTypes <- readBin(buf[i0 + 5], "integer", n = 1, size = 1, signed = FALSE)
        # cat(" ", vectorShow(numberOfDataTypes))
        i <- i + 1
        rval$offset <- readBin(buf[i0 + 6:7], "integer", n = 1, size = 2, signed = FALSE)
        # cat(" ", vectorShow(offset))
        # buf[offset + 2]
        rval$i <- i0
        rval$iNext <- i0 + 8
        rval
    }
}

readFirstLeader <- function(buf, i, debug = 0) {
    if (debug > 0) cat("in readFirstLeader(buf, i=", i, ")\n", sep = "")
    if (buf[i] != 0x03 || buf[i + 1] != 0x01) {
        warning("first 2 bytes are not 0x03 0x01", .immediate = TRUE)
        list(type = "error", i = i)
    } else {
        i0 <- 8
        rval <- list(type = "firstLeader")
        i <- i + 2 # skip the 0x03 0x01 bytes
        rval$firmwareVersion <- readBin(buf[i0 + 3:4], "integer", size = 2)
        # cat(" ", vectorShow(firmwareVersion, postscript = "(how to decode?)"))
        i <- i + 2
        rval$configuration <- buf[i0 + 5:6]
        # cat(" ", vectorShow(configuration, postscript = "(binary)"))
        i <- i + 2
        rval$nbins <- as.integer(buf[i0 + 7])
        # cat(" ", vectorShow(nbins))
        i <- i + 1
        rval$waveRecPings <- readBin(buf[i0 + 8:9], "integer", size = 2, signed = FALSE)
        # cat(" ", vectorShow(waveRecPings))
        i <- i + 2
        # report in m, not cm
        rval$binLength <- 1e-4 * readBin(buf[i0 + 10:11], "integer", size = 2, signed = FALSE)
        # cat(" ", vectorShow(binLength, postscript = "cm"))
        i <- i + 2
        rval$TBP <- 0.01 * readBin(buf[i0 + 12:13], "integer", size = 2, signed = FALSE)
        # cat(" ", vectorShow(TBP, postscript = "s"))
        i <- i + 2
        rval$TBB <- 0.01 * readBin(buf[i0 + 14:15], "integer", size = 2, signed = FALSE)
        # cat(" ", vectorShow(TBB, postscript = "s"))
        i <- i + 2
        rval$distMidBin1 <- 1e-4 * readBin(buf[i0 + 16:17], "integer", size = 2, signed = FALSE)
        # cat(" ", vectorShow(distMidBin1, postscript = "cm"))
        i <- i + 2
        rval$binsOut <- as.integer(buf[i0 + 18])
        i <- i + 1
        # cat(" ", vectorShow(binsOut))
        i <- i + 2 # SelectedData (reserved)
        i <- i + 16 # DWSBins
        i <- i + 16 # VelBins
        # 19+34=53
        century <- as.integer(buf[i0 + 53])
        # cat(" ", vectorShow(century))
        i <- i + 1
        year <- century * 100 + as.integer(buf[i0 + 54])
        # cat(" ", vectorShow(year))
        i <- i + 1
        month <- as.integer(buf[i0 + 55])
        # cat(" ", vectorShow(month))
        i <- i + 1
        day <- as.integer(buf[i0 + 56])
        # cat(" ", vectorShow(day))
        i <- i + 1
        hour <- as.integer(buf[i0 + 57])
        # cat(" ", vectorShow(hour))
        i <- i + 1
        minute <- as.integer(buf[i0 + 58])
        # cat(" ", vectorShow(minute))
        i <- i + 1
        second <- as.integer(buf[i0 + 59])
        # cat(" ", vectorShow(second))
        i <- i + 1
        second100 <- as.integer(buf[i0 + 60])
        # cat(" ", vectorShow(second100))
        i <- i + 1
        rval$time <- ISOdatetime(year, month, day, hour, minute, second + second100, tz = "UTC")
        # cat(" ", vectorShow(time))
        rval$burstNumber <- readBin(buf[i0 + 61:64], "integer", size = 4)
        # cat(" ", vectorShow(burstNumber))
        i <- i + 4
        rval$serialNumber <- readBin(buf[i0 + 65:72], "integer", size = 8)
        # print(buf[i+0:7])
        # cat(" ", vectorShow(serialNumber, postscript = paste("at i=", i)))
        i <- i + 8
        rval$temperature <- readBin(buf[i0 + 73:74], "integer", size = 2)
        # cat(" ", vectorShow(temperature, postscript = "unit? factor?"))
        i <- i + 2
        i <- i + 2 # reserved
        # assume 2 more bytes for checksum, hence 81 below
        rval$i <- i0
        rval$iNext <- i0 + 81
        c(type = "firstLeader", rval)
    }
}

readWavePing <- function(buf, i, debug = 0) {
    if (debug > 0) cat("in readWavePing(buf, i=", i, ")\n", sep = "")
    if (buf[i] != 0x03 || buf[i + 1] != 0x02) {
        warning("first 2 bytes are not 0x03 0x02", .immediate = TRUE)
        list(i = i)
    } else {
        i0 <- i
        rval <- list(type = "wavePing")
        i <- i + 2 # skip the 0x03 0x01 bytes
        rval$pingNumber <- readBin(buf[i0 + 2:3], "integer", size = 2)
        # FIXME: manual does not say how these are stored
        rval$timeSinceStart <- 0.01 * readBin(buf[i0 + 4:7], "integer",
            size = 4,
            endian = "little"
        )
        # 1 dbar ~ 0.1 atm = 1e4 Pa
        rval$pressure <- 1e-4 * readBin(buf[i0 + 8:11], "integer",
            size = 4,
            endian = "little"
        )
        # getting 11 or so, for the test file for oce issue 2216; this
        # cannot be right.
        rval$distanceToSurface <- 1e-3 * readBin(buf[i0 + 12:27], "integer",
            size = 4, n = 4, endian = "little"
        )
        return(rval)
        # cat(" ", vectorShow(firmwareVersion, postscript = "(how to decode?)"))
        i <- i + 2
        rval$configuration <- buf[i0 + 5:6]
        # cat(" ", vectorShow(configuration, postscript = "(binary)"))
        i <- i + 2
        rval$nbins <- as.integer(buf[i0 + 7])
        # cat(" ", vectorShow(nbins))
        i <- i + 1
        rval$waveRecPings <- readBin(buf[i0 + 8:9], "integer", size = 2, signed = FALSE)
        # cat(" ", vectorShow(waveRecPings))
        i <- i + 2
        # report in m, not cm
        rval$binLength <- 1e-4 * readBin(buf[i0 + 10:11], "integer", size = 2, signed = FALSE)
        # cat(" ", vectorShow(binLength, postscript = "cm"))
        i <- i + 2
        rval$TBP <- 0.01 * readBin(buf[i0 + 12:13], "integer", size = 2, signed = FALSE)
        # cat(" ", vectorShow(TBP, postscript = "s"))
        i <- i + 2
        rval$TBB <- 0.01 * readBin(buf[i0 + 14:15], "integer", size = 2, signed = FALSE)
        # cat(" ", vectorShow(TBB, postscript = "s"))
        i <- i + 2
        rval$distMidBin1 <- 1e-4 * readBin(buf[i0 + 16:17], "integer", size = 2, signed = FALSE)
        # cat(" ", vectorShow(distMidBin1, postscript = "cm"))
        i <- i + 2
        rval$binsOut <- as.integer(buf[i0 + 18])
        i <- i + 1
        # cat(" ", vectorShow(binsOut))
        i <- i + 2 # SelectedData (reserved)
        i <- i + 16 # DWSBins
        i <- i + 16 # VelBins
        # 19+34=53
        century <- as.integer(buf[i0 + 53])
        # cat(" ", vectorShow(century))
        i <- i + 1
        year <- century * 100 + as.integer(buf[i0 + 54])
        # cat(" ", vectorShow(year))
        i <- i + 1
        month <- as.integer(buf[i0 + 55])
        # cat(" ", vectorShow(month))
        i <- i + 1
        day <- as.integer(buf[i0 + 56])
        # cat(" ", vectorShow(day))
        i <- i + 1
        hour <- as.integer(buf[i0 + 57])
        # cat(" ", vectorShow(hour))
        i <- i + 1
        minute <- as.integer(buf[i0 + 58])
        # cat(" ", vectorShow(minute))
        i <- i + 1
        second <- as.integer(buf[i0 + 59])
        # cat(" ", vectorShow(second))
        i <- i + 1
        second100 <- as.integer(buf[i0 + 60])
        # cat(" ", vectorShow(second100))
        i <- i + 1
        rval$time <- ISOdatetime(year, month, day, hour, minute, second + second100, tz = "UTC")
        # cat(" ", vectorShow(time))
        rval$burstNumber <- readBin(buf[i0 + 61:64], "integer", size = 4)
        # cat(" ", vectorShow(burstNumber))
        i <- i + 4
        rval$serialNumber <- readBin(buf[i0 + 65:72], "integer", size = 8)
        # print(buf[i+0:7])
        # cat(" ", vectorShow(serialNumber, postscript = paste("at i=", i)))
        i <- i + 8
        rval$temperature <- readBin(buf[i0 + 73:74], "integer", size = 2)
        # cat(" ", vectorShow(temperature, postscript = "unit? factor?"))
        i <- i + 2
        i <- i + 2 # reserved
        # assume 2 more bytes for checksum, hence 81 below
        rval$i <- i0
        rval$iNext <- i0 + 81
        rval
    }
}

processChunk <- function(buf, i, debug = 0) {
    if (buf[i] == 0x7f && buf[i + 1] == 0x79) {
        readHeader(buf, i, debug = debug)
    } else if (buf[i] == 0x03 && buf[i + 1] == 0x01) {
        readFirstLeader(buf, i, debug = debug)
    } else if (buf[i] == 0x03 && buf[i + 1] == 0x02) {
        readWavePing(buf, i, debug = debug)
    } else {
        stop(
            "unknown chunk at i=", i, "; found 0x", buf[i], " 0x",
            buf[i + 1]
        )
    }
}

#<> i <- 1
#<> if (buf[i] == 0x7f && buf[i + 1] == 0x79) {
#<>     header1 <- readHeader(buf, i, debug = debug)
#<>     cat("# header1\n")
#<>     cat(str(header1))
#<>     i <- header1$iNext
#<>     if (buf[i] == 0x03 && buf[i + 1] == 0x01) {
#<>         firstLeader1 <- readFirstLeader(buf, i)
#<>         cat("# firstLeader1\n")
#<>         cat(str(firstLeader1))
#<>         cat(vectorShow(buf[firstLeader1$iNext + 0:10], n = -1))
#<>         # cat(
#<>         #    "Note: 7f79 found 4 bytes later. This is surprising to me.\n",
#<>         #    "* Why is this not a ping, which the manual suggests?\n",
#<>         #    "* Did I misunderstand the table?\n",
#<>         #    "* Is the table wrong?\n",
#<>         #    "* Are checksums 4 bytes in this file type?\n",
#<>         #    "* And -- for later -- what is the checksum formula?\n"
#<>         # )
#<>     }
#<> }
#<>
i <- 1
for (ichunk in 1:10) {
    chunk <- processChunk(buf, i)
    cat(chunk$type, "\n")
    i <- chunk$iNext
    cat(str(chunk))
    if (is.null(i)) {
        message("done processing")
        return()
    }
    #message("set i=", i)
}
# firstLeader$nbins = 35
# firstLeader$binsOut = 5
# str(processChunk(buf, 9))
# 80 - (2+2+4+4+16+2*5*4   + 2) # is this 0 or maybe 2 if checksum?
