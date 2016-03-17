## We now have Nortek docs on the c3 format. Let's test the values.
library(oce)
dir <- "~/Dropbox/OCE-ADV-IMU-Mr2"

o <- read.oce("~/Dropbox/OCE-ADV-IMU-Mr2/I5080902.VEC")

## names are in ~/Dropbox/OCE-ADV-IMU-Mr2/I5080902.hdr

col.names <- c("burst", "ensemble",
               "v1", "v2", "v3",
               "a1", "a2", "a3",
               "snr1", "snr2", "snr3",
               "cor1", "cor2", "cor3", 
               "p",
               "ai1","ai2",
               "checksum",
               "ensembleCounter", 
               "timer",
               "da1", "da2", "da3",
               "dv1", "dv2", "dv3",
               "m11", "m12", "m13",
               "m21", "m22", "m23",
               "m31", "m32", "m33",
               "heading", "pitch", "roll")

t <- read.table("~/Dropbox/OCE-ADV-IMU-Mr2/I5080902.dat", header=FALSE, col.names=col.names)
t[1:2,]
str(o@data)
stopifnot(all.equal.numeric(o[['v']][,1], t$v1))
stopifnot(all.equal.numeric(o[['v']][,2], t$v2))
stopifnot(all.equal.numeric(o[['v']][,3], t$v3))
stopifnot(all.equal.numeric(as.numeric(o[['a']][,1]), t$a1))
stopifnot(all.equal.numeric(as.numeric(o[['a']][,2]), t$a2))
stopifnot(all.equal.numeric(as.numeric(o[['a']][,3]), t$a3))
## FIXME: does oce read 'snr'? (If so, what is it called?)
message("does oce read SNR?")
stopifnot(all.equal.numeric(as.numeric(o[['q']][,1]), t$cor1))
stopifnot(all.equal.numeric(as.numeric(o[['q']][,2]), t$cor2))
stopifnot(all.equal.numeric(as.numeric(o[['q']][,3]), t$cor3))
stopifnot(all.equal.numeric(o[['pressure']], t$p))
message("does oce read ai1 (analogue input 1)?")
message("does oce read ai2 (analogue input 2)?")
message("does oce read checksum?")
message("does oce read ensembleCounter?")
## Note: the .dat file only gives 3 digits on the counter, so set weak tolerance
stopifnot(all.equal.numeric(o[['IMUtime']], t$timer, tolerance=0.01))
## Note: the .VEC stores in radians (despite what it says in the
## system integrator document, March 2016). Also, we have to use
## a coarse resolution because the .dat file only gives 4 digits after
## the decimal
stopifnot(all.equal.numeric(o[["IMUdeltaAngleX"]]*180/pi, t$da1, tolerance=0.001))
stopifnot(all.equal.numeric(o[["IMUdeltaAngleY"]]*180/pi, t$da2, tolerance=0.001))
stopifnot(all.equal.numeric(o[["IMUdeltaAngleZ"]]*180/pi, t$da3, tolerance=0.001))
## Note: the .dat has only 5 digits after the decimal place, but the first two seem
## always to be 00, so don't have a lot of digits to check ... set tolerance 
## to a very coarse value.
stopifnot(all.equal.numeric(o[["IMUdeltaVelocityX"]], t$dv1, tolerance=0.01))
stopifnot(all.equal.numeric(o[["IMUdeltaVelocityY"]], t$dv2, tolerance=0.1))
stopifnot(all.equal.numeric(o[["IMUdeltaVelocityZ"]], t$dv3, tolerance=1))
message("ERROR -- something is wrong with deltaVelocityY and Z")
head(t$dv3)
## [1] -0.29789 -0.29734 -0.29677 -0.29800 -0.29689 -0.29947
head(o[['IMUdeltaVelocityZ']])
fivenum(t$dv3 - o[["IMUdeltaVelocityZ"]], na.rm=TRUE)
##[1] -0.03037681 -0.03032058 -0.03026246 -0.03038788 -0.03027449 -0.03053777

stopifnot(all.equal.numeric(t$m11, o[['IMUrotation']][1,1,], tolerance=0.0001))
stopifnot(all.equal.numeric(t$m12, o[['IMUrotation']][1,2,], tolerance=0.0001))
stopifnot(all.equal.numeric(t$m13, o[['IMUrotation']][1,3,], tolerance=0.001))
stopifnot(all.equal.numeric(t$m21, o[['IMUrotation']][2,1,], tolerance=0.0001))
stopifnot(all.equal.numeric(t$m22, o[['IMUrotation']][2,2,], tolerance=0.0001))
stopifnot(all.equal.numeric(t$m23, o[['IMUrotation']][2,3,], tolerance=0.001))
stopifnot(all.equal.numeric(t$m31, o[['IMUrotation']][3,1,], tolerance=0.001))
stopifnot(all.equal.numeric(t$m32, o[['IMUrotation']][3,2,], tolerance=0.001))
stopifnot(all.equal.numeric(t$m33, o[['IMUrotation']][3,3,], tolerance=0.0001))
message("ERROR: oce is not reading pitch, heading, and roll")

