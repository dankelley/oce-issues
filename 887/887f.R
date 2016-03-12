## coordinate rotation -- a rough trial, not compensating for up/down stuff

# use dolfyn-supplied test data, one file with IMU, the other without it.

mag <- function(x) sqrt(sum(x^2))


library(oce)

message("\n* ~/src/dolfyn/example_data/vector_data_imu01.VEC")
dimu <- read.oce("~/src/dolfyn/example_data/vector_data_imu01.VEC")
summary(dimu)
v <- dimu[['v']]

## values from 887.py -- see if we get same as dolfyn
u3p <- c(-0.92200005, -0.87800002, -0.85400003)
v3p <- c(0.23900001, 0.27900001, 0.22000001)
w3p <- c(-0.055, -0.055, -0.061)

stopifnot(all.equal.numeric(v[1:3,1], u3p, tolerance=1e-6))
stopifnot(all.equal.numeric(v[1:3,2], v3p, tolerance=1e-6))
stopifnot(all.equal.numeric(v[1:3,3], w3p, tolerance=1e-6))

if (!interactive()) png("887f.png")
s <- 2
par(mfcol=c(3,3), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
oce.plot.ts(dimu[['time']], dimu[['v']][,1], ylab="u", ylim=c(-s,s), drawTimeRange=FALSE)
oce.plot.ts(dimu[['time']], dimu[['v']][,2], ylab="v", ylim=c(-s,s), drawTimeRange=FALSE)
oce.plot.ts(dimu[['time']], dimu[['v']][,3], ylab="w", ylim=c(-s,s), drawTimeRange=FALSE)

## some abbreviations for interactive work here, messing with matrix multiplication
r <- dimu[['IMUrotation']]
v <- dimu[['v']]
n <- dim(v)[1]

enu <- matrix(unlist(lapply(1:n,
                            function(i) r[,,i] %*% v[i,])),
              nrow=n, byrow=TRUE)
## Do just one, by hand, to check that we are filling matrix correctly

## Without extra flipping
V1 <- r[,,1] %*% v[1,]
sum(V1^2)/sum(v[1,]^2)
dim(enu) <- dim(v)
stopifnot(all.equal.numeric(V1[,1], enu[1,]))

## With extra flipping
## http://cs.nortek.no/scripts/customer.fcgi/getAttachment/483-NQM3q5dFGdKrCuJmaNNDcSQo6aLejC4CPrrtqXaQG2WpkbQnAd4lGEb8MhLzYc60-0/nortek-vector-and-microstrain-support-memo-july.pdf
## Caution: the above has typos e.g. I think their final eqn
## V_{earth norek} = T_{Earth} M^{-1} T_{Local}^{-1} V_{Earth Microstrain}
## should perhaps have V_{xyz microstrain} as the last element.
TE <- cbind(c(0,1,0), c(1,0,0), c(0,0,-1))
TE
TL <- cbind(c(0,0,-1), c(0,1,0), c(1,0,0))
TL
TLi <- solve(TL)                       # matrix inverse
TLi

## a simple test is that the vector length is identical
ENU <- TE %*% solve(r[,,1]) %*% TLi %*% v[1,]
stopifnot(all.equal.numeric(mag(ENU), mag(v[1,])))
ENU <- matrix(unlist(lapply(1:n,
                            function(i) TE %*% solve(r[,,i]) %*% TLi %*% v[i,])),
              nrow=n, byrow=TRUE)


oce.plot.ts(dimu[['time']], enu[,1], ylim=c(-s,s), ylab="u rotated", drawTimeRange=FALSE)
oce.plot.ts(dimu[['time']], enu[,2], ylim=c(-s,s), ylab="v rotated", drawTimeRange=FALSE)
oce.plot.ts(dimu[['time']], enu[,3], ylim=c(-s,s), ylab="w rotated", drawTimeRange=FALSE)

oce.plot.ts(dimu[['time']], ENU[,1], ylim=c(-s,s), ylab="u rotated 2", drawTimeRange=FALSE)
oce.plot.ts(dimu[['time']], ENU[,2], ylim=c(-s,s), ylab="v rotated 2", drawTimeRange=FALSE)
oce.plot.ts(dimu[['time']], ENU[,3], ylim=c(-s,s), ylab="w rotated 2", drawTimeRange=FALSE)

if (!interactive()) dev.off()

## test rotation against dolfyn (fails to march)
enuU3 <- c(-0.57547349, -0.51025897, -0.52240831)
enuV3 <- c(-0.75291842, -0.76149833, -0.70425189)
enuW3 <- c(0.11033722, 0.10726681, 0.11205319)
enu1p <- c(enuU3[1], enuV3[1], enuW3[1])
mag(enu1p)
mag(v[1,])
mag(enu[1,])
mag(ENU[1,])
data.frame(v[1,], enu[1,], ENU[1,], enu1p)


