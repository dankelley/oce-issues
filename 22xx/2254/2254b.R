# Small dataset: no problem with filling across NAs
library(oce)
N <- 500
y <- sin(seq_len(N) * 2 * pi / 50)
t <- as.POSIXct(Sys.Date()) + 1:N
y[100:200] <- NA
if (!interactive()) png("2254b.png")
par(mfcol=c(2, 2))
oce.plot.ts(t, y, type="p", cex = 0.2)
oce.plot.ts(t, y, type="l")
X <- 1:10
Y <- X * (1 - X)
Y[3:5] <- NA
plot(X, Y)
plot(X, Y, type = "l")
if (!interactive()) dev.off()
