##  at cindex=166769238 (17.755% through file) chunk=20624: size=12 id=0x23 dataSize=16032 dataChecksum=1155 headerChecksum=5495
##  at cindex=166785282 (17.756% through file) chunk=20625: size=10 id=0x1c dataSize=952 dataChecksum=13270 headerChecksum=2011
##  at cindex=166786244 (17.757% through file) chunk=20626: size=12 id=0x23 dataSize=16032 dataChecksum=62255 headerChecksum=1059
## warning: ldc_ad2cp_in_file() at cindex=166786256 (17.757% through file), cindex_last_good=166785282, data checksum is 63402 but it should be 62255
## warning: expected header.sync to be 0xa5 but it was 0x00 at cindex=166802288 (17.758% through file) ... skipping to next 0xa5 chacter...
## ... got a sync character (0xa5) at cindex=166821940 (17.76% through file) so trying to continue from there
## Error in do_ldc_ad2cp_in_file(filename, from, to, by, debug - 1) : 
##   header_size is 165, but it must be 10 or 12 at cindex=166821940 (17.76% through file)
## Calls: read.oce -> read.adp.ad2cp -> do_ldc_ad2cp_in_file
library(oce)
fileSize <- 939294720
o <- seq(0, 12)
buf <- readBin("~/Dropbox/S101135A001_Ronald.ad2cp", what="raw", n=fileSize)

cindex_last_good <- 166785282
data.frame(o, buf=buf[cindex_last_good + o + 1]) # the +1 is to go from C to R
dataSize <- 16032
O <- seq(-20, 20)
i <- seq(-dataSize, 5*dataSize)
B <- buf[cindex_last_good + i]
if (!interactive()) png("1676c.png", width=7, height=3, unit="in", res=150, pointsize=9)
par(mar=c(3,3,1,1), mgp=c(2,0.7,0))
plot(i, as.integer(B), pch=".",
     xlab="Byte index past start of bad chunk",
     ylab="Integer value of byte")
abline(v=0, col=2, lwd=2)
abline(v=dataSize, col=4, lwd=2)
mtext("Red: start of first invalid data chunk", adj=0, col=2)
mtext("Blue: expected end of invalid data chunk", adj=1, col=4)
if (!interactive()) dev.off()
