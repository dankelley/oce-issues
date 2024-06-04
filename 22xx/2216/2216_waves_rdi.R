library(oce)
f <- "~/Downloads/oce2216.000"
buf <- readBin(f, "raw", n = 1e4)
readHeader <- function(buf, i) {
    cat("readHeader(buf, i=", i, ") -- wavemon manual sec 4.5 table 16\n", sep = "")
    rval <- list()
    i <- i + 2
    rval$checksumOffset <- readBin(buf[i + 0:1], "integer", n = 1, size = 2)
    # cat(" ", vectorShow(checksumOffset))
    i <- i + 2
    rval$spare <- buf[i]
    # cat(" ", vectorShow(spare))
    i <- i + 1
    rval$numberOfDataTypes <- readBin(buf[i], "integer", n = 1, size = 1)
    # cat(" ", vectorShow(numberOfDataTypes))
    i <- i + 1
    rval$offset <- readBin(buf[i + 0:1], "integer", n = 1, size = 2)
    # cat(" ", vectorShow(offset))
    # buf[offset + 2]
    rval$iNext <- i + 2
    rval
}


i <- 1

if (buf[i] == 0x7f && buf[i + 1] == 0x79) {
    header <- readHeader(buf, i)
    cat(str(header))
    message("line 30")
    i <- header$iNext
    if (buf[i] == 0x03 && buf[i + 1] == 0x01) {
        i <- i + 2
        cat("First Leader (0x03 0x01) at index ", i, "\n")
        firmwareVersion <- readBin(buf[i + 0:1], "integer", size = 2)
        cat(" ", vectorShow(firmwareVersion, postscript = "(how to decode?)"))
        i <- i + 2
        configuration <- buf[i + 0:1]
        cat(" ", vectorShow(configuration, postscript = "(binary)"))
        i <- i + 2
        nbins <- as.integer(buf[i])
        cat(" ", vectorShow(nbins))
        i <- i + 1
        waveRecPings <- readBin(buf[i + 0:1], "integer", size = 2)
        cat(" ", vectorShow(waveRecPings))
        i <- i + 2
        binLength <- 0.01 * readBin(buf[i + 0:1], "integer", size = 2)
        cat(" ", vectorShow(binLength, postscript = "cm"))
        i <- i + 2
        TBP <- 0.01 * readBin(buf[i + 0:1], "integer", size = 2)
        cat(" ", vectorShow(TBP, postscript = "s"))
        i <- i + 2
        TBB <- 0.01 * readBin(buf[i + 0:1], "integer", size = 2)
        cat(" ", vectorShow(TBB, postscript = "s"))
        i <- i + 2
        distMidBin1 <- 0.01 * readBin(buf[i + 0:1], "integer", size = 2)
        cat(" ", vectorShow(distMidBin1, postscript = "cm"))
        i <- i + 2
        binsOut <- as.integer(buf[i])
        i <- i + 1
        cat(" ", vectorShow(binsOut))
        i <- i + 2 # SelectedData (reserved)
        i <- i + 16 # DWSBins
        i <- i + 16 # VelBins
        century <- as.integer(buf[i])
        cat(" ", vectorShow(century))
        i <- i + 1
        year <- 2000 + as.integer(buf[i]) # guess on the 2000
        cat(" ", vectorShow(year))
        i <- i + 1
        month <- as.integer(buf[i])
        cat(" ", vectorShow(month))
        i <- i + 1
        day <- as.integer(buf[i])
        cat(" ", vectorShow(day))
        i <- i + 1
        hour <- as.integer(buf[i])
        cat(" ", vectorShow(hour))
        i <- i + 1
        minute <- as.integer(buf[i])
        cat(" ", vectorShow(minute))
        i <- i + 1
        second <- as.integer(buf[i])
        cat(" ", vectorShow(second))
        i <- i + 1
        second100 <- as.integer(buf[i])
        cat(" ", vectorShow(second100))
        time <- ISOdatetime(year, month, day, hour, minute, second + second100, tz = "UTC")
        cat(" ", vectorShow(time))
        i <- i + 1
        burstNumber <- readBin(buf[i + 0:3], "integer", size = 4)
        cat(" ", vectorShow(burstNumber))
        i <- i + 4
        serialNumber <- buf[i + 0:7]
        cat(" ", vectorShow(serialNumber, postscript = paste("at i=", i)))
        i <- i + 8
        temperature <- readBin(buf[i + 0:1], "integer", size = 2)
        cat(" ", vectorShow(temperature, postscript = "unit? factor?"))
        i <- i + 2
        i <- i + 2 # reserved
        cat("  at i=", i, ", next 2 bytes: 0x", buf[i], " 0x", buf[i + 1],
            " (is this a checksum?)\n",
            sep = ""
        )
        i <- i + 2
        cat("  at i=", i, ", next 2 bytes: 0x", buf[i], " 0x", buf[i + 1],
            " (what is this?)\n",
            sep = ""
        )
        i <- i + 2
        if (buf[i] == 0x7f && buf[i + 1] == 0x79) {
            header2 <- readHeader(buf, i)
            cat(str(header2))
        }
        message("DAN")
        cat("  at i=", i, ", next 2 bytes: 0x", buf[i], " 0x", buf[i + 1],
            " (huh? expect 0x03 0x02)\n",
            sep = ""
        )
        # print(data.frame(ioff=seq(-15,15), buf=buf[i+seq(-15,15)]))
        cat("The docs don't say how long the checksum is.\nMaybe it is 4 bytes. But then the next\nitem is 7F 79, which disagrees with the docs.\n")
    } else {
        cat("  ERROR: want 0x01 0x03 (first leader) but got 0x",
            buf[i], " 0x", buf[i + 1], "\n",
            sep = ""
        )
    }
}
