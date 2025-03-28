library(oce)
library(testthat)
data(section)
stn <- section[["station", 3]]
options(digits=10, width=100)
par(mfrow=c(2,1), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))

options(oceEOS="gsw")
A <- stn[["sigmaTheta"]]
options(oceEOS="unesco")
B <- stn[["sigmaTheta"]]

S <- stn[["salinity"]]
T <- stn[["temperature"]]
p <- stn[["pressure"]]
longitude <- stn[["longitude"]]
latitude <- stn[["latitude"]]

AA <- swSigmaTheta(S, T, p, longitude=longitude, latitude=latitude, eos="gsw")
BB <- swSigmaTheta(S, T, p, eos="unesco")
##AA - BB
## ensure that manual calculation agrees with [[ method (FIXME: add to test suite)
expect_equal(A, AA)
expect_equal(B, BB)

SA <- stn[["SA"]]
CT <- stn[["CT"]]
## ensure that manual calculation agrees with [[ method (FIXME: add to test suite)
expect_equal(SA,
             gsw_SA_from_SP(SP=S, p=p, longitude=longitude, latitude=latitude))
expect_equal(CT, gsw_CT_from_t(SA=SA, t=T, p=p))

df <- data.frame(S=S, T=T, p=p, SA=SA, CT=CT, st_gsw=AA, st_unesco=BB, diffPercent=200*(AA-BB)/(AA+BB))
print(df)
##plot(df$st_unesco, df$st_unesco - df$st_gsw, ylim=c(-0.006, -0.002), type='o')
plot(df$st_unesco, df$st_unesco - df$st_gsw, type="o", xlab="sigmaTheta unesco", ylab="sigthe unesco-gsw")
grid()

pd <- function(a, b) 200*(a-b)/(a+b)
plot(df$st_unesco, pd(df$st_unesco, df$st_gsw), type="o", xlab="sigmaTheta unesco", ylab="sigthe unesco-gsw (%)")

grid()
