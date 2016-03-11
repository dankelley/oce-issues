## coordinate rotation -- a rough trial, not compensating for up/down stuff

# use dolfyn-supplied test data, one file with IMU, the other without it.


rm(list=ls())

library(oce)

message("\n* ~/src/dolfyn/example_data/vector_data_imu01.VEC")
dimu <- read.oce("~/src/dolfyn/example_data/vector_data_imu01.VEC")
summary(dimu)

if (!interactive()) png("887e.png")
s <- 2
par(mfcol=c(3,2), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
plot(dimu[['time']], dimu[['v']][,1], ylab="u", ylim=c(-s,s))
plot(dimu[['time']], dimu[['v']][,2], ylab="v", ylim=c(-s,s))
plot(dimu[['time']], dimu[['v']][,3], ylab="w", ylim=c(-s,s))

r<-dimu[['IMUrotation']]
v<-dimu[['v']]
n <- dim(v)[1]
B <- unlist(lapply(1:n, function(i) r[,,i] %*% v[i,]))
length(B)
dim(B) <- dim(v)
oce.plot.ts(dimu[['time']], B[,1], ylim=c(-s,s), ylab="U")
oce.plot.ts(dimu[['time']], B[,2], ylim=c(-s,s), ylab="V")
oce.plot.ts(dimu[['time']], B[,3], ylim=c(-s,s), ylab="W")


if (!interactive()) dev.off()

