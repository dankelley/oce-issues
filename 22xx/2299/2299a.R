library(oce)
source("~/git/oce/R/spectral.R")
#> Loading required package: gsw
Fs <- 1000
t <- seq(0, 0.296, 1 / Fs)
x <- cos(2 * pi * t * 200) + rnorm(n = length(t))
X <- ts(x, frequency = Fs)
s <- spectrum(X, spans = c(3, 2), main = "random + 200 Hz", log = "no")
w <- pwelch(X, plot = FALSE, debug = 1)
lines(w$freq, w$spec, col = "red")
#w2 <- pwelch(X, nfft = 75, plot = FALSE, spec=spec.pgram, debug = 1)
#lines(w2$freq, w2$spec, col = "red")
