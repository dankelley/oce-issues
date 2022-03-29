library(oce)
read.ctd.ssda <- function(file, debug=getOption("oceDebug"))
{
    l <- readLines(file)
    dataStart <- grep("^Lines[ ]*:[ ]*[0-9]*$", l)
    if (1 != length(dataStart))
        stop("cannot find 'Lines :' in the data file.")
    # how many lines might there be in between?
    dataNames <- strsplit(gsub("^;[ ]*", "", l[dataStart+2L]), "[ ]+")[[1]]
    dataNamesOriginal <- dataNames
    # Use standard oce names for some things. (Thanks to Liam MacNeil for pointing these out.)
    nameMapping <- list(
        bottom="Boden",
        conductivity="Lietf",
        fluorescence="Licor",
        latitude="Lat",
        longitude="Long",
        oxygenSaturation="AO2_%",
        oxygenMg="AO2mg",
        oxygenMl="AO2ml",
        pressure="Druck",
        salinity="SALIN",
        oxygenVoltage="RawO2",
        sigma="SIGMA",
        temperature="Temp.")
    for (name in names(nameMapping)) {
        nameInFile <- nameMapping[[name]]
        dataNames[dataNames == nameInFile] <- name
    }
    d <- read.table(file, skip=dataStart + 4, col.names=dataNames, header=FALSE)
    # Not sure on the "N" in latitude. We need docs to know what is possible
    # in the location strings.
    lon <- as.numeric(d$longitude[1])
    londeg <- floor(lon / 100)
    lonmin <- lon - londeg*100
    longitude <- londeg + lonmin / 60.0
    oceDebug(debug, "lon=", lon, " deg=", londeg, " min=", lonmin, " -> longitude=", longitude, "\n")
    lat <- as.numeric(gsub("N","",d$latitude[1]))
    latdeg <- floor(lat / 100)
    latmin <- lat - latdeg*100
    latitude <- latdeg + latmin / 60.0
    oceDebug(debug, "lat=", lat, " deg=", latdeg, " min=", latmin, " -> latitude=", latitude, "\n")
    ctd <- as.ctd(salinity=d$salinity, temperature=d$temperature, pressure=d$pressure,
        longitude=longitude, latitude=latitude)
    ctd@metadata$dataNamesOriginal <- nameMapping
    # Add non-standard data
    for (n in names(d)) {
        if (!n %in% c(c("salinity", "pressure", "temperature", "latitude", "longitude"))) {
            ctd <- oceSetData(ctd, n, d[[n]], note=NULL)
        }
    }
    # We add time, whilst still retaining the raw data used for it (as a check).
    time <- as.POSIXct(paste(d$IntDT, d$IntDT.1), "%d.%m.%Y %H:%M:%S", tz="UTC")
    ctd <- oceSetData(ctd, "time", time, note=NULL)
    # Handle some conversions and units
    if ("oxygenVoltage" %in% names(ctd@data)) {
        # file has in mV but oce uses V
        ctd@data$oxygenVoltage <- 0.001 * ctd@data$oxygenVoltage
        ctd@metadata$units$oxygenVoltage <- list(unit=expression(V), scale="")
    }
    if ("oxygenSaturation" %in% names(ctd@data)) {
        ctd@metadata$units$oxygenSaturation<- list(unit=expression(percent), scale="")
    }
    ctd
}
d <- read.ctd.ssda("14190549.csv")

head(d[["salinity"]]) # a check agaist the file
summary(d)
if (!interactive())
    png("1909a.png")
plot(d, span=3000)
# test time decoding
df <- data.frame(d[["time"]], d[["IntDT"]], d[["IntDT.1"]])
head(df)
if (!interactive())
    dev.off()


