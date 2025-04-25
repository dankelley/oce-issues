library(oce)
library(signal)
taper <- 0.1

t <- seq(0, 365 * 24)
x <- 0
for (i in 2:length(t)) {
    x[i] <- 0.99 * x[i - 1] + rnorm(1, sd = 0.1)
}
# Add 2 frequencies, one in pass band, the other in cut band
x <- x + cos(2 * pi / (4 * 12.42) * t)
x <- x + cos(2 * pi / 12.42 * t)

if (!interactive()) pdf("01.pdf")

par(mfrow = c(3, 1), mar = c(3, 3, 1, 1), mgp = c(1.5, 0.5, 0))
plot(t, x, type = "l", lwd = 0.5)

spec <- spectrum(ts(x, deltat = 1), spans = c(3, 5), plot = FALSE)
fc <- 1 / 34
w <- fc / (0.5)

plot(log10(spec$freq), log10(spec$spec),
    type = "l", xlab = "log10(Frequency [cph])", ylab = "log10(Spectrum)",
    ylim = c(-15, 3), lwd = 0.5
)
grid()
abline(v = log10(fc), lty = 2)
for (order in 1:8) {
    bw <- butter(order, w)
    xf <- filtfilt(bw, x)
    specf <- spectrum(ts(xf, deltat = 1), spans = c(3, 5), plot = FALSE)
    lines(log10(specf$freq), log10(specf$spec), col = order + 1, lwd = 0.5)
}
legend("bottomleft", c("Raw", paste0("bw order=", 1:8)), col = 1:8, lty = 1)
title("Periodogram")
grid()
abline(v = log10(fc), lty = 2)
for (order in 1:8) {
    bw <- butter(order, w)
    xf <- filtfilt(bw, x)
    specf <- spectrum(ts(xf, deltat = 1), spans = c(3, 5), plot = FALSE)
    lines(log10(specf$freq), log10(specf$spec), col = order + 1, lwd = 0.5)
}
legend("bottomleft", c("Raw", paste0("bw order=", 1:8)), col = 1:8, lty = 1)
title("Periodogram")

source("my_pwelch.R")
plot(log10(spec$freq), log10(spec$spec),
    type = "l", xlab = "log10(Frequency [cph])", ylab = "log10(Spectrum)",
    ylim = c(-15, 3), lwd = 0.5
)
grid()
abline(v = log10(fc), lty = 2)
for (order in 1:8) {
    bw <- butter(order, w)
    xf <- filtfilt(bw, x)
    specf <- my_pwelch(ts(xf, deltat = 1), taper = taper, plot = FALSE)
    lines(log10(specf$freq), log10(specf$spec), col = order + 1, lwd = 0.5)
}
legend("bottomleft", c("Raw", paste0("bw order=", 1:8)), col = 1:8, lty = 1)
title("My Welch")

nsegments <- length(DEBUG$segment)
par(mfrow = c(4, 2))
ylim <- c(-1, 1) * max(sapply(DEBUG$segments, \(s) abs(s)))
for (segment in DEBUG$segments) {
    plot(seq_along(segment), segment, ylim = ylim, type = "l")
    abline(h = 0, col = 2)
}
if (!interactive()) dev.off()
