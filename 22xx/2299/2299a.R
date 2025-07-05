library(oce)
set.seed(20250702) # for reproducibility
# if (file.exists("~/git/oce/R/spectral.R")) {
#    source("~/git/oce/R/spectral.R")
# }
if (!interactive()) {
    png("2299a.png", units = "in", width = 7, height = 3.5, res = 300)
}
par(mar = c(3, 3, 1, 1), mgp = c(2, 0.7, 0))
Fs <- 1000
t <- seq(0, 0.296, 1 / Fs)
x <- cos(2 * pi * t * 200) + rnorm(n = length(t))
X <- ts(x, frequency = Fs)
s <- spectrum(X, spans = c(3, 2), main = "spectrum() with random + 200 Hz", log = "no", plot = FALSE)
w <- pwelch(X, plot = FALSE, debug = 1)

# Issue says next breaks ... and, yes, it does. A traceback()
# on Wed  2 Jul 2025 08:59:39 ADT) indicates the problem is in
# spectral.R#223.
test <- function(x, ...) spec.pgram(x, ..., plot = FALSE)
w2 <- pwelch(X, nfft = 75, plot = FALSE, spec = test, debug = 1)

ylim <- range(c(s$spec, w$spec, w2$spec)) * c(-0.01, 1.04)
plot(s$freq, s$spec,
    type = "l", ylim = ylim,
    xlab = "Frequency [Hz]", ylab = "Spectrum", xaxs = "i", yaxs = "i"
)
mtext("Noise (stddev=1) + 200Hz signal (amplitude=1)")

lines(w$freq, w$spec, col = 2)
lines(w2$freq, w2$spec, col = 4)
grid()
legend("topright", col = c(1, 2, 4), lwd = 1, legend = c("spectrum()", "pwelch()", "pwelch() with spec supplied"), bg = "white")

print(t.test(w2$spec / w$spec))

if (!interactive()) {
    dev.off()
}
