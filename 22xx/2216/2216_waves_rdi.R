library(oce)
f <- "~/Downloads/oce2216.000"
buf <- readBin(f, "raw", n = 1e4)
i <- 1
if (buf[i] == 0x7f && buf[i + 1] == 0x79) {
    cat("Got 0x7f 0x79 (for waves type) see wavemon manual section 4.5 table 16\n")
    i <- i + 2
    checksumOffset <- readBin(buf[i + 0:1], "integer", n = 1, size = 2)
    cat(" ", vectorShow(checksumOffset))
    i <- i + 2
    spare <- buf[i]
    cat(" ", vectorShow(spare))
    i <- i + 1
    numberOfDataTypes <- readBin(buf[i], "integer", n = 1, size = 1)
    cat(" ", vectorShow(numberOfDataTypes))
    i <- i + 1
    offset <- readBin(buf[i + 0:1], "integer", n = 1, size = 2)
    cat(" ", vectorShow(offset))
    buf[offset + 2]
    i <- offset + 1
    if (buf[i] == 0x03 && buf[i + 1] == 0x01) {
        i <- i + 2
        cat("  First Leader Type at index ", i, "\n")
        firmwareVersion <- readBin(buf[i + 0:1], "integer", size = 2)
        cat(" ", vectorShow(firmwareVersion, postscript = "(how to decode?)"))
        i <- i + 2
        configuration <- buf[i + 0:1]
        cat(" ", vectorShow(configuration, postscript = "(binary)"))
        i <- i + 2
        nbins <- as.integer(buf[i])
        cat(" ", vectorShow(nbins))
        i <- i + 1
        samplesPerBurst <- readBin(buf[i + 0:1], "integer", size = 2)
        cat(" ", vectorShow(samplesPerBurst))
        i <- i + 2
        binLength <- 0.01 * readBin(buf[i + 0:1], "integer", size = 2)
        cat(" ", vectorShow(binLength, postscript="cm"))
        i <- i + 2
        TBP <- 0.01 * readBin(buf[i + 0:1], "integer", size = 2)
        cat(" ", vectorShow(TBP, postscript="s"))
        i <- i + 2
        TBB <- 0.01 * readBin(buf[i + 0:1], "integer", size = 2)
        cat(" ", vectorShow(TBB, postscript="s"))
        i <- i + 2
    } else {
        cat("  ERROR: want 0x01 0x03 (first leader) but got 0x",
            buf[i], " 0x", buf[i + 1], "\n",
            sep = ""
        )
    }
}
