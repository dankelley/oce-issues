# is split(...,indInterval()) faster than split(...,cut())?
t0 <- as.POSIXct("2021-01-01", tz="UTC")
Ns <- 10^seq(3, 8, 0.25)
As <- rep(NA, length(Ns))
Bs <- rep(NA, length(Ns))

for (i in seq_along(Ns)) {
    t <- t0 + seq(1, Ns[i])
    ninterval <- 2560L
    y <- rnorm(Ns[i])
    df <- data.frame(t, y)
    b <- seq(min(t), max(t), length.out=ninterval)
    As[i] <- system.time(A <- split(df, cut(t, b)))[1]
    Bs[i] <- system.time(B <- split(df, findInterval(t, b)))[1]
}

par(mfrow=c(2,1), mar=c(3,3,1,1), mgp=c(2,0.7,0))
plot(Ns, As, type="o", log="x", ylim=range(c(As,Bs)),
     xlab="Number of Data Points", ylab="User Time [s]")
lines(Ns, Bs, type="o", col=2)
legend("topleft", col=1:2, lwd=1, pch=1, legend=c("cut", "findInterval"))
plot(Ns, As/Bs, type="b", log="x",
     xlab="Number of Data Points", ylab="Time Reduction Factor")
data.frame(N=Ns, cutTime=As, findIntervalTime=Bs)
