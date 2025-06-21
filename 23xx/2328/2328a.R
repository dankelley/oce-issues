library(oce)
file <- "TEST_RUN_BOAT_DATA_3.cnv"
# d <- read.oce(f, debug = 3)
lines <- readLines(file)
endOfHeader <- grep("^\\*END\\*", lines)
if (length(endOfHeader) != 1) stop("cannot find *END* line")
# determine names (close to, but not quite right for oce)
nameLines <- lines[grep("name [0-9]* =", lines)]
names <- gsub(".*= ([a-zA-Z]*) .*$", "\\1", nameLines)
data <- read.table(file, skip = endOfHeader, col.names = names)
range(data$pressure)
range(data[,1])
data[data == -9.999] <- NA # noticed in file
data[data == -9.99e-29] <- NA # notice in file (huh? TWO missing values????)
str(data, 1)
ctd <- as.ctd(
    salinity = data$salinity,
    temperature = data$temperature,
    pressure = data$pressure,
    longitude = data$longitude,
    latitude = data$latitude
)
summary(ctd)
if (!interactive()) png("2328a_%02d.png", units = "in", width = 7, height = 7, res = 200)
plot(ctd)
plot(ctd[["latitude"]])
plot(ctd[["longitude"]], type="l")
diff(ctd[["longitude"]])
if (!interactive()) dev.off()
