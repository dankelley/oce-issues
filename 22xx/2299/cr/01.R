library(oce)
library(signal)

t <- seq(0, 365 * 24)
x <- 0
for (i in 2:length(t)) {
    x[i] <- 0.99 * x[i - 1] + rnorm(1, sd=0.1)
}
# Add a tidal component just for fun
x <- x + 1 * cos(2*pi / 12.42 * t)

if (!interactive()) pdf('01.pdf')

par(mfrow = c(2, 1), mar = c(3, 3, 1, 1), mgp = c(1.5, 0.5, 0))
plot(t, x, type = "l")

spec <- spectrum(ts(x, deltat = 1), spans = c(3, 5), plot = FALSE)
fc <- 1/34
w <- fc / (0.5)

plot(log10(spec$freq), log10(spec$spec),
    type = "l", xlab = "log10(Frequency [cph])", ylab = "log10(Spectrum)",
    ylim = c(-15, 3)
)
grid()
abline(v = log10(fc), lty = 2)
for (order in 1:8) {
    bw <- butter(order, w)
    xf <- filtfilt(bw, x)
    specf <- spectrum(ts(xf, deltat = 1), spans = c(3, 5), plot = FALSE)
    lines(log10(specf$freq), log10(specf$spec), col = order + 1)
}
legend("bottomleft", c("Raw", paste0("bw order=", 1:8)), col = 1:8, lty = 1)
title('Periodogram')

plot(log10(spec$freq), log10(spec$spec),
    type = "l", xlab = "log10(Frequency [cph])", ylab = "log10(Spectrum)",
    ylim = c(-15, 3)
)
grid()
abline(v = log10(fc), lty = 2)
for (order in 1:8) {
    bw <- butter(order, w)
    xf <- filtfilt(bw, x)
    specf <- spectrum(ts(xf, deltat = 1), spans = c(3, 5), plot = FALSE)
    lines(log10(specf$freq), log10(specf$spec), col = order + 1)
}
legend("bottomleft", c("Raw", paste0("bw order=", 1:8)), col = 1:8, lty = 1)
title('Periodogram')

source('my_pwelch.R')
plot(log10(spec$freq), log10(spec$spec),
    type = "l", xlab = "log10(Frequency [cph])", ylab = "log10(Spectrum)",
    ylim = c(-15, 3)
)
grid()
abline(v = log10(fc), lty = 2)
for (order in 1:8) {
    bw <- butter(order, w)
    xf <- filtfilt(bw, x)
    # specf <- spectrum(ts(xf, deltat = 1), spans = c(3, 5), plot = FALSE)
    # specf <- my_pwelch(ts(xf, deltat = 1), plot = FALSE, debug=10, spec=spec.pgram, nfft=1024)
    specf <- my_pwelch(ts(xf, deltat = 1), plot = FALSE)
    lines(log10(specf$freq), log10(specf$spec), col = order + 1)
}
legend("bottomleft", c("Raw", paste0("bw order=", 1:8)), col = 1:8, lty = 1)
title('My Welch')

if (!interactive()) dev.off()
