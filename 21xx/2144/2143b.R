library(oce)
options(width=200)
tRef <- as.POSIXct("2023-08-15", tz="UTC")
latitude <- 21+18.2/60 # https://tidesandcurrents.noaa.gov/stationhome.html?id=1612340

# The const.txt file was created by copying from the website for Hawaii, viz.
# <https:tidesandcurrents.noaa.gov/harcon.html?id=1612340>. The column names are
# 'Constituent..', 'Name', 'Amplitude', 'Phase', 'Speed', and 'Description'.
const <- read.delim("const.txt", sep="\t", header=TRUE)
tm <- as.tidem(tRef=tRef, latitude=latitude, name=const$Name, amplitude=const$Amplitude, phase=const$Phase)

