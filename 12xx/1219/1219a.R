library(oce)
f <- "/Users/kelley/Dropbox/oce_ad2cp/labtestsig3.ad2cp"
N <- 50
d <- read.ad2cp(f, 1, N, 1)
print(d)
par(mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
plot(d$id, ylim=c(20.5,22.5), type='p', cex=2/3, ylab="chunk type", lwd=2)
grid()

## I know that the second one is a data/burst chunk. I think it is
## version "3", at least in the beginning ones. Certainly, the time
## fields seem (mostly) to be ok (except that they are slightly
## out of order).
time <- vector("numeric", N)
id <- vector("numeric", N)
version <- vector("numeric", N)
soundSpeed <- vector("numeric", N)
temperature <- vector("numeric", N)
pressure <- vector("numeric", N)
heading <- vector("numeric", N)
pitch <- vector("numeric", N)
roll <- vector("numeric", N)

options(digits.secs=6)
for (ch in 1:N) {
    id[ch] <- d$id[ch]
    if (d$id[ch] %in% c(21, 22)) {
        version[ch] <- as.integer(d$buf[d$index[ch]+1]) ## this is 3
        if (version[ch] == 3) {
            year<-as.integer(d$buf[d$index[ch]+1+8])
            month<-as.integer(d$buf[d$index[ch]+1+9])
            day<-as.integer(d$buf[d$index[ch]+1+10])
            hour<-as.integer(d$buf[d$index[ch]+1+11])
            min<-as.integer(d$buf[d$index[ch]+1+1[ch]])
            sec<-as.integer(d$buf[d$index[ch]+1+13])
            usec100 <- readBin(d$buf[d$index[ch]+c(15,16)], "integer", size=2, signed=FALSE, endian="little")
            t <- ISOdatetime(1900+year,month,day,hour,min,sec+usec100/1e4,tz="UTC")
            time[ch] <- t
            soundSpeed[ch] <- 0.1 * readBin(d$buf[d$index[ch]+c(17,18)], "integer", size=2, endian="little")
            temperature[ch] <- 0.01 * readBin(d$buf[d$index[ch]+c(19,20)], "integer", size=2, endian="little")
            pressure[ch] <- 0.001 * readBin(d$buf[d$index[ch]+c(21,22)], "integer", size=2, endian="little")
            heading[ch] <- 0.01 * readBin(d$buf[d$index[ch]+c(23,24)], "integer", size=2, endian="little")
            pitch[ch] <- 0.01 * readBin(d$buf[d$index[ch]+c(25,26)], "integer", size=2, endian="little")
            roll[ch] <- 0.01 * readBin(d$buf[d$index[ch]+c(27,28)], "integer", size=2, endian="little")
            cat("chunk ", ch, " decoded\n")
        } else {
            cat("chunk ", ch, " is id=", d$id[ch], " version=", version, "\n", sep="")
        }
    } else {
        cat("chunk ", ch, " is id=", d$id[ch], "\n", sep="")
    }
}
options(width=120) # to get wide printing
time <- as.POSIXct(time, origin="1970-01-01 00:00:00", tz="UTC")
res <- data.frame(time, id, version, soundSpeed, temperature, pressure, heading, pitch, roll)
print(res)

