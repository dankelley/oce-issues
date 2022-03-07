# find data columns by counting commas there and in header

library(oce)

f <- "Custom.export.026043_2021-07-21_17-36-45.txt"
file <- file(f, "r")
lines <- readLines(file, encoding="UTF-8-BOM", warn=FALSE)
nfields <- length(strsplit(",", lines[1])[[1]])
col.names <- strsplit(lines[1], ",")[[1]]
if (!("Date" %in% col.names))
    stop("No 'Date' column found")
if (!("Time" %in% col.names))
    stop("No 'Time' column found")
if (!("Temperature (C)" %in% col.names))
    stop("No 'Temperature (C)' column found")
col.names[col.names == "Temperature (C)"] <- "temperature"
if (!("Conductivity (mS/cm)" %in% col.names))
    stop("No 'Conductivity (mS/cm)' column found")

col.names[col.names == "Conductivity (mS/cm)"] <- "conductivity"
col.names[col.names == "Depth (m)"] <- "depth"
col.names[col.names == "Battery (V)"] <- "battery"
nfields <- length(col.names)
nfield <- unlist(lapply(lines, function(l) length(strsplit(l, ",")[[1]])))
nfield[1]
look <- nfield == nfield[1]
head(lines[look])
d <- read.csv(text=lines[look], skip=1, col.names=col.names)
close(file)

d$time <- as.POSIXct(paste(d$Date, d$Time), tz="UTC")
if ("depth" %in% names(d)) {
    d$pressure <- swPressure(d[["depth"]], 45)
}

print(head(d, 2))
d$salinity <- swSCTp(d$conductivity, d$temperature, d$pressure, conductivityUnit="mS/cm")
ctd <- as.ctd(salinity=d$salinity,
    temperature=d$temperature,
    pressure=d$pressure,
    longitude=-60, # FIXME
    latitude=45, # FIXME
    )

dno <- list(salinity="-", temperature="Temperature (C)", conductivity="Conductivity (mS/cm)",
    Date="Date", Time="Time")
if ("depth" %in% names(d))
    dno$depth <- "Depth (m)"
if ("battery" %in% names(d))
    dno$battery <- "Battery (V)"
ctd@metadata$dataNamesOriginal <- dno
# Fixme maybe add voltage here?  (But I think there are tons of things to maybe add.)
for (name in names(d)) {
    if (name != "temperature" && name != "salinity" && name != "pressure") {
        ctd <- oceSetData(ctd, name, d[[name]], note=NULL)
    }
}
summary(ctd)

