library(oce)
t1 <- Sys.time()
days <- c(0.5, 2.5, 3)
if (!interactive()) png("1018a.png")
par(mfrow=c(length(days), 1))
for (day in days) {
    t2 <- t1 + day * 86400
    t <- seq(t1, t2, 600)
    x <- sin(2*pi*as.numeric(t)/86400)
    oce.plot.ts(t, x, debug=3)
}
if (!interactive()) dev.off()

