library(oce)
source("~/git/oce/R/xbt.R")
# https://www.ncei.noaa.gov/archive/archive-management-system/OAS/bin/prd/jquery/accession/download/7301162
# next is a helper for checking what we are reading
read.xbt.ubt.oneline <- function(line, debug = 0) {
    S <- function(x) {
        if (debug) {
            cat(deparse(substitute(expr = x, env = environment())), ": '", x, "'\n", sep = "")
        }
    }
    oceDebug(debug, vectorShow(line))
    WMOquadrant <- substr(line, 3, 3)
    S(WMOquadrant)
    if (!WMOquadrant %in% c(1, 3, 5, 7)) {
        stop("area=", WMOquadrant, " is not in permitted list 1, 3, 5 or 7")
    }
    latitudeDDMMX <- substr(line, 4, 8)
    S(latitudeDDMMX)
    latDeg <- as.integer(substr(latitudeDDMMX, 1, 2))
    latMin <- as.integer(substr(latitudeDDMMX, 3, 4))
    latX <- substr(latitudeDDMMX, 5, 5)
    S(latX)
    latX <- if (identical(latX, " ")) 0 else as.integer(latX)
    S(latX)
    S(as.integer(latX))
    latitude <- latDeg + (latMin + latX / 10) / 60
    S(latitude)

    latitudeHemisphere <- substr(line, 9, 9)
    S(latitudeHemisphere)
    if (!latitudeHemisphere %in% c("S", "N")) {
        stop("latitudeHemisphere=", latitudeHemisphere, " must be 'S' or 'N'")
    }
    if (latitudeHemisphere == "S") {
        latitude <- -latitude
    }
    latitudePrecision <- substr(line, 10, 10)
    S(latitudePrecision)

    longitudeDDDMMX <- substr(line, 11, 16)
    S(longitudeDDDMMX)
    lonDeg <- as.integer(substr(longitudeDDDMMX, 1, 3))
    S(lonDeg)
    lonMin <- as.integer(substr(longitudeDDDMMX, 4, 5))
    S(lonMin)
    lonX <- substr(longitudeDDDMMX, 6, 6)
    S(lonX)
    lonX <- if (identical(lonX, " ")) 0 else as.integer(lonX)
    S(lonX)
    longitude <- lonDeg + (lonMin + lonX / 10) / 60
    S(longitude)


    longitudeHemisphere <- substr(line, 17, 17)
    S(longitudeHemisphere)
    if (!longitudeHemisphere %in% c("E", "W")) {
        stop("longitudeHemisphere=", longitudeHemisphere, " must be 'E' or 'W'")
    }
    longitudePrecision <- substr(line, 18, 18)
    S(longitudePrecision)
    YYYYMMDD <- substr(line, 19, 26)
    S(YYYYMMDD)
    HHMM <- substr(line, 27, 30)
    S(HHMM)
    time <- ISOdatetime(as.integer(substr(YYYYMMDD, 1, 4)),
        as.integer(substr(YYYYMMDD, 5, 6)),
        as.integer(substr(YYYYMMDD, 7, 8)),
        as.integer(substr(HHMM, 1, 2)),
        as.integer(substr(HHMM, 3, 4)),
        sec = 0,
        tz = "UTC"
    )

    if (!FALSE) { # why bother even updating these checks, since clearly the docs are wrong
        blank1 <- substr(line, 32, 32)
        S(blank1)
        country <- substr(line, 33, 34)
        S(country)
        blank2 <- substr(line, 35, 35)
        S(blank2)
        S(l)
    }
    # Skip a lot of things, since the above seem (maybe) OK and I want to get to
    # the "good stuff"
    bottomDepth <- substr(line, 82, 85)
    S(bottomDepth) # why blank? maybe I don't worry, though
    # OK, let's skip to see if we can find T=T(z) data, AKA the "good stuff".
    count <- as.integer(substr(line, 96, 99))
    S(count)
    if (count <= 0) {
        stop("count=", count, " is not possible")
    }
    depth <- rep(NA, count)
    temperature <- rep(NA, count)
    offset <- 101 # character offset
    for (i in seq_len(count)) {
        depth[i] <- as.numeric(substr(line, offset, offset + 3)) # metres
        temperature[i] <- 0.01 * as.numeric(substr(line, offset + 4, offset + 7)) # factor yields degC
        offset <- offset + 8
    }
    if (debug) {
        print(data.frame(depth = depth, temperature = temperature))
    }
    rval <- new("xbt")
    rval@metadata$longitude <- longitude
    rval@metadata$latitude <- latitude
    rval@metadata$time <- time
    rval@data$depth <- depth
    rval@data$temperature <- temperature
    rval@data$pressure <- pressure
    rval
}
read.xbt.ubt <- function(filename) {
    lines <- readLines(filename)
    lapply(lines, \(line) read.xbt.ubt.oneline(line))
}

# Test with multi-profile file
file <- "44687"
xbts <- read.xbt.ubt(file)
if (!interactive()) {
    png("2289e_%02d.png")
}
for (xbt in xbts) {
    plot(xbt)
    mtext(sprintf(
        "%.4fN %.4fE %s", xbt[["latitude"]], xbt[["longitude"]],
        xbt[["time"]]
    ), line = -1)
}
lon <- sapply(xbts, \(x) x[["longitude"]])
lat <- sapply(xbts, \(x) x[["latitude"]])
par(mar = c(3, 3, 1, 1))
plot(-lon, lat, asp = 1 / cos(mean(range(lat)) * pi / 180))
if (!interactive()) {
    dev.off()
}
