# demonstrate what taper does to an FFT
if (!interactive()) png("2299b_%02d.png", pointsize = 12)
for (taper in c(0, 0.05, 0.1, 0.15, 0.2)) {
    n <- 256
    x <- rnorm(n, sd = 0.05)
    x <- rep(1, n)
    frequency <- seq(0, 0.5, length.out = n / 2)
    x <- spec.taper(x, p = taper)
    t <- seq_along(x)
    par(mfrow = c(2, 2), mar = c(3, 3, 2, 1), mgp = c(1.5, 0.5, 0))
    plot(t, x, type = "l")
    mtext(paste0("taper=", taper))
    X <- abs(fft(x))[1:(n / 2)]
    plot(frequency, X, type = "l")
    plot(frequency, log10(X), type = "l")
    plot(log10(frequency), log10(X), asp = 1 / 3, type = "l")
    slope <- -3
    for (a in seq(-10, 10, 0.5)) {
        abline(a, slope, col = 2)
    }
    mtext(paste0("red lines have slope=", slope))
}
if (!interactive()) dev.off()

# x <- rep(1, 100)
# t <- seq_along(x)
# plot(t, x, type = "l", lwd=2, ylim = c(0, 1))
# lines(t, spec.taper(x, 0.1), col=2, lwd=2)
# lines(t, spec.taper(x, 0.2), col=3, lwd=2)
# lines(t, spec.taper(x, 0.3), col=4, lwd=2)
