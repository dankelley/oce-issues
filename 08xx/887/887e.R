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
oce.plot.ts(dimu[['time']], dimu[['v']][,1], ylab="u", ylim=c(-s,s), grid=TRUE)
oce.plot.ts(dimu[['time']], dimu[['v']][,2], ylab="v", ylim=c(-s,s), grid=TRUE)
oce.plot.ts(dimu[['time']], dimu[['v']][,3], ylab="w", ylim=c(-s,s), grid=TRUE)

## some abbreviations for interactive work here, messing with matrix multiplication
r <- dimu[['IMUrotation']]
v <- dimu[['v']]
n <- dim(v)[1]
B <- matrix(unlist(lapply(1:n, function(i) r[,,i] %*% v[i,])), nrow=n, byrow=TRUE)
## Do just one, by hand, to check that we are filling matrix correctly
V1 <- lapply(1, function(i) r[,,i] %*% v[i,])
sum(V1[[1]]^2)/sum(v[1,]^2)
dim(B) <- dim(v)
V1[[1]]
B[1,]
stopifnot(V1[[1]]==B[1,])
oce.plot.ts(dimu[['time']], B[,1], ylim=c(-s,s), ylab="u rotated", grid=TRUE)
oce.plot.ts(dimu[['time']], B[,2], ylim=c(-s,s), ylab="v rotated", grid=TRUE)
oce.plot.ts(dimu[['time']], B[,3], ylim=c(-s,s), ylab="w rotated", grid=TRUE)


if (!interactive()) dev.off()

