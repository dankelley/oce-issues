#' Read adp data from RDI-created text file
#'
#' @param file character string indicating the file name
#'
#' @value An object of \code{adp-class}.
read.adp.rdi.text <- function(file, debug=getOption("oceDebug"))
{
    oceDebug(debug, "read.adp.rdi.text {\n", unindent=1)
    if (is.character(file)) {
        filename <- fullFilename(file)
        file <- file(file, "rb")
        on.exit(close(file))
    }
    if (!inherits(file, "connection"))
        stop("argument `file' must be a character string or connection")
    if (!isOpen(file)) {
        filename <- "(connection)"
        open(file, "rb")
        on.exit(close(file))
    }
    res <- new("adp")
    ## Next caches the data
    if (debug > 0) {
        if (!exists("dataLines"))
            dataLines <<- readLines(file)
    } else {
        dataLines <- readLines(file)
    }
    ndataLines <- length(dataLines)
    header <- dataLines[which(grepl("^Num,.*$", dataLines))]
    nheader <- length(header)
    numberOfBeams <- (nheader - 1) / 3 # three types: velo, intensity, and correlation
    oceDebug(debug, "numberOfBeams =", numberOfBeams, "\n")
    if (numberOfBeams != floor(numberOfBeams))
        stop("cannot calculate the number of beams from the header length")
    ## dataLines <- dataLines[-seq.int(1, nheader)]
    numberOfProfiles <- (ndataLines - nheader) / (1 + 3 * numberOfBeams) - 1
    oceDebug(debug, "numberOfProfiles =", numberOfProfiles, "\n")
    if (numberOfProfiles != floor(numberOfProfiles))
        stop("cannot calculate the number of profiles from the header length")
    pitch <- vector("numeric", numberOfProfiles)
    roll <- vector("numeric", numberOfProfiles)
    heading <- vector("numeric", numberOfProfiles)
    temperature <- vector("numeric", numberOfProfiles)
    time <- vector("numeric", numberOfProfiles)
    ## calculate number of cells by looking at the first velocity line
    ## the 7 in next line accounts for Num,Year,Month,Day,Hour,Min,Sec
    numberOfCells <- length(strsplit(dataLines[nheader+2], split=",")[[1]]) - 7
    ## message("numberOfCells = ", numberOfCells)
    v <- array(numeric(), dim=c(numberOfProfiles, numberOfCells, numberOfBeams))
    idataLine <- nheader + 1
    for (iprofile in seq_len(numberOfProfiles)) {
        ## message("TOP idataLine = ", idataLine, ": ", dataLines[idataLine])
        ## Pitch, Roll, etc
        items <- strsplit(dataLines[idataLine], split=",")[[1]]
        num <- items[1]
        year <- items[2]
        month <- items[3]
        day <- items[4]
        hour <- items[5]
        min <- items[6]
        sec <- items[7]
        pitch[iprofile] <- items[8]
        roll[iprofile] <- items[9]
        heading[iprofile] <- items[10]
        temperature[iprofile] <- items[11]
        t <- ISOdatetime(year, month, day, hour, min, sec, tz="UTC")
        ##message("  inferred profile =", iprofile, ", t=", t)
        time[iprofile] <- as.numeric(t)
        idataLine <- idataLine + 1

        for (ibeam in seq_len(numberOfBeams)) {
            ##message("V   idataLine = ", idataLine, ": ", dataLines[idataLine])
            items <- strsplit(dataLines[idataLine], split=",")[[1]]
            nitems <- length(items)
            ##message("V   idataLine = ", idataLine, ", nitems = ", nitems)
            if (nitems != 7 + numberOfCells) {
                ##message("canot get velocity from line: idataLine=", idataLine)
            }
            v[iprofile, , ibeam] <- as.numeric(items[8:nitems]) ## ignore first 7 items; rest are velocities
            ##message("  infered for iprofile=",iprofile,", ibeam=", ibeam)
            idataLine <- idataLine + 1
        }
        idataLine <- idataLine + numberOfBeams # skip intensity
        idataLine <- idataLine + numberOfBeams # skip correlation
    }
    res@metadata$numberOfCells <- numberOfCells
    res@metadata$numberOfBeams <- numberOfBeams
    res@metadata$numberOfProfiles <- numberOfProfiles
    res@metadata$cellSize <- 1
    res@data$distance <- seq(0, by=res@metadata$cellSize, length.out=numberOfCells)
    time[time==0] <- NA
    res@data$time <- as.POSIXct(time, origin="1970-01-01", tz="UTC")
    res@data$pitch <- pitch
    res@data$roll <- roll
    res@data$heading <- heading
    res@data$temperature <- temperature
    v[!is.finite(v)] <- NA
    res@data$v <- v
    oceDebug(debug, "} # read.adp.rdi.text\n", unindent=1)
    warning("guessing at cell size")
    res
}

