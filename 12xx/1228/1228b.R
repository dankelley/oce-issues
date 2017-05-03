DP <- 0.128 # inferred pressure change in matlab
icutoff <- 8281 # at end, where matlab and oce disagree (by eye on graph)
o <- 1 # the offset we need to compare (since oce is losing first ensemble)
library(R.matlab)
library(oce)
library(testthat)
options(digits=10)
options(digits.secs=4)

#load("~/Dropbox/buf0.rda")
# paste("0x", paste(head(buf,50), collapse=" 0x"), sep="")
# 0x7f 0x7f 0xe3 0x02 0x00 0x07 0x14 0x00 0x4f 0x00 0x90 0x00 0x5a 0x01 0xc0 0x01 0x26 0x02 0x8c 0x02 0x00 0x00 0x33 0x28 0xca 0x41 0x00 0x0d 0x04 0x19 0x50 0x00 0x90 0x01 0xb0 0x00 0x01 0x40 0x09 0x00 0xd0 0x07 0x00 0x03 0x00 0x17 0x00 0x00 0x00 0x00

m <- readMat("adcp.mat")
## source("~/git/oce/R/oce.R")
## source("~/git/oce/R/adp.rdi.R")
## source("~/git/oce/R/misc.R")
## source("~/git/oce/R/imagep.R")
## source("~/git/oce/R/processingLog.R")
d <- read.oce("adcp.000", debug=3)

toce <- d[["time"]]
tmat <- ISOdatetime(as.vector(2000+m$SerYear), 
                    as.vector(m$SerMon),
                    as.vector(m$SerDay),
                    as.vector(m$SerHour),
                    as.vector(m$SerMin),
                    as.vector(m$SerSec)+as.vector(m$SerHund)/100, tz="UTC")
expect_equal(toce, tmat)

## Panels show matlab on left, oce on right
tudf <- data.frame(toce=toce, uoceTOP=d[["v"]][,1,1], umatTOP=m$SerEmmpersec[,1]/1000.0)
cat("head of surface velocities compared\n")
print(head(tudf))
cat("tail of surface velocities compared\n")
print(tail(tudf))
cat("surface velocities compared at indices ", icutoff, "+seq(-5,5)\n")
print(tudf[icutoff+seq.int(-5, 5), ])

ylim <- c(-1, 1)
if (!interactive()) png("1228b.png", unit="in", width=7, height=7, res=150, pointsize=11)
par(mfcol=c(3, 2), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
oce.plot.ts(tmat, m$SerEmmpersec[,1]/1000.0, ylim=ylim, ylab="mat E")
n <- 100
oce.plot.ts(head(tmat,n), head(m$SerEmmpersec[,1]/1000.0,n), ylim=ylim, ylab="mat E")
oce.plot.ts(tail(tmat,n), tail(m$SerEmmpersec[,1]/1000.0,n), ylim=ylim, ylab="mat E")

oce.plot.ts(toce, d[["v"]][,1,1], ylim=ylim, ylab="oce 1")
oce.plot.ts(head(toce,n), head(d[["v"]][,1,1],n), ylim=ylim, ylab="oce 1")
oce.plot.ts(tail(toce,n), tail(d[["v"]][,1,1],n), ylim=ylim, ylab="oce 1")

if (!interactive()) dev.off()

file <- file("adcp.000","rb")
seek(file, 0, "start")
seek(file, where=0, origin="end")
fileSize <- seek(file, where=0)
bufFile <- readBin(file, what="raw", n=fileSize, endian="little")
close(file)
n <- min(c(length(bufFile), length(ldc$outbuf)))
mismatched <- sum(bufFile[1:n]!=ldc$outbuf[1:n])
message("n=", n, ", mismatched=", mismatched)

message("length(ldc$outbuf)=", length(ldc$outbuf), "; expect ", 6168576)
