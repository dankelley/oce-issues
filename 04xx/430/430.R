# http://mashable.com/2014/03/25/developing-storm-canada/
library(oce)
##  #YY  MM DD hh mm WDIR WSPD GST  WVHT   DPD   APD MWD   PRES  ATMP  WTMP  DEWP  VIS PTDY  TIDE
##  #yr  mo dy hr mn degT m/s  m/s     m   sec   sec degT   hPa  degC  degC  degC  nmi  hPa    ft
##  2014 04 18 17 00 290  7.0  9.0   1.8     7    MM  MM 1034.0   0.2   1.3    MM   MM -3.0    MM
##  2014 04 18 16 00 280  8.0 10.0   1.8     7    MM  MM 1034.0   0.0   1.3    MM   MM -4.1    MM
##  2014 04 18 15 00 270  7.0  9.0   1.7     7    MM  MM 1036.3  -0.1   1.2    MM   MM -2.2    MM

if (!exists("d"))
    d <- read.table("http://www.ndbc.noaa.gov/data/realtime2/44258.txt",
                    stringsAsFactors=FALSE, skip=2)
t <- ISOdatetime(d[,1], d[,2], d[,3], d[,4], d[,5], 0)
d[d == "MM"] <- NA                     # weird missing code
footPerMetre <- 39.3701 / 12
windSpeed <- as.numeric(d[,7])
waveHeight <- as.numeric(d$V9)
wavePeriod <- as.numeric(d[,10])
par(mfrow=c(3,1))
oce.plot.ts(t, windSpeed, ylab="Wind Speed [m/s]")
oce.plot.ts(t, waveHeight, ylab="Height [m]")
oce.plot.ts(t, wavePeriod, ylab="Period")

## demo ccf
par(mfrow=c(1,1))
ws <- windSpeed
ws[is.na(ws)] <- mean(ws,na.rm=TRUE)
wh <- waveHeight
wh[is.na(wh)] <- mean(wh,na.rm=TRUE)
ccf <- ccf(ws,wh)
l <- runlm(ccf$lag, ccf$acf, L=3)
str(l)

