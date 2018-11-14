library(oce)
if (file.exists("2062a.cnv")) { # PRIVATE file
    microcat <- read.oce("2062a.cnv")
    microcat <- oceSetMetadata(microcat, "deploymentType", "moored")
    ## Get system upload time, which should give us the year of the recovery
    ## time. We'll need that because we are going to construct time from
    ## the timeJV2 column.
    microcat[["metadata"]][["startTime"]]
    microcat[["time"]]
    ## Now, we ought to check on how many days the machine has been
    ## recording, because it could be multiple years, and if so we'll
    ## need to set our start time accordingly
    range(microcat[["timeJV2"]])
    ## OK, under a year. Assuming no wrap-around (which would give an upper range
    ## of 365 or 366), we can now make a time column.  NOTE: this Julian day starts
    ## at 1.0 for the first second of January.
    t0 <- as.POSIXct("2018-01-01 00:00:00", tz="UTC")
    t <- t0 + 86400 * (microcat[["timeJV2"]] - 1)
    ## Let's insert this into the data
    microcat <- oceSetData(microcat, "time", t)

    ## Fix up the longitude
    microcat <- oceSetMetadata(microcat, "longitude", -microcat[["longitude"]])


    if (!interactive()) png("1457b.png")
    plot(microcat)
    if (!interactive()) dev.off()


    cat("t range: ", format(min(t)), "to", format(max(t)), "\n")
    header <- microcat[["header"]]
    cat("datacnv_date=", header[grep("datcnv_date", header)], "\n")
    cat("systemUploadTime: ", format(microcat[["systemUploadTime"]]), "\n")
}
