# Large dataset: problem with filling across NAs
library(oce)
N <- 50000 # make long to force oce.plot.ts() to simplify it
y <- sin(seq_len(N) * 2 * pi / 5000)
t <- as.POSIXct(Sys.Date()) + 1:N
y[1000:5000] <- NA
if (!interactive()) png("2254a.png")
par(mfcol = c(2, 2))
oce.plot.ts(t, y, type = "p", cex = 0.2)
oce.plot.ts(t, y, type = "l")
X <- 1:10
Y <- X * (1 - X)
Y[3:5] <- NA
plot(X, Y)
plot(X, Y, type = "l")
if (!interactive()) dev.off()
