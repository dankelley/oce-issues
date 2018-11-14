library(oce)
if (file.exists("2062a.cnv")) { # PRIVATE file
    microcat <- read.oce("2062a.cnv")
    ## Fix up the longitude, which has a sign error
    microcat <- oceSetMetadata(microcat, "longitude", -microcat[["longitude"]])
    ## Indicate that instrument was moored, not profiled
    microcat <- oceSetMetadata(microcat, "deploymentType", "moored")
    summary(microcat) # examine data names and processing log
    if (!interactive()) png("1457c_all.png")
    plot(microcat)
    if (!interactive()) dev.off()
    if (!interactive()) png("1457c_underwater.png")
    microcatUnderwater <- subset(microcat, pressure > 30)
    plot(microcatUnderwater)
    if (!interactive()) dev.off()
}

