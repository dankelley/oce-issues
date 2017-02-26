rm(list=ls())
library(oce)

data(section)
s <- section
s@metadata$date <- NULL

## scramble the stations
n <- length(section[['station']])
o <- sample(1:n)
section@data$station <- s@data$station[o]
section@metadata$date <- s@metadata$date[o]
section@metadata$stationId <- s@metadata$stationId[o]
section@metadata$longitude <- s@metadata$longitude[o]
section@metadata$latitude <- s@metadata$latitude[o]

d <- sectionSort(section, 'time')

if (!interactive()) png('950a.png')

par(mfrow=c(2, 1))
plot(s, which=1, xtype='time')
plot(d, which=1, xtype='time')
mtext('Expect as above, after sorting scrambled section in time', font=2, col='purple')

if (!interactive()) dev.off()
