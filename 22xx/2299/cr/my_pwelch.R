my_pwelch <- function(x, nwindow = 8, overlap = 0.5, window = "hamming", plot = TRUE) {
    # Window can be "rectangular", "blackman-harris", "hann", "hamming"
    fs <- frequency(x)
    N <- length(x)
    # determine segment length
    n <- floor(N / (nwindow * (1 - overlap) + overlap))
    s <- spec.pgram(x[1:n], plot = FALSE)
    f <- s$freq
    # Set up the windowing function:
    w <- oce::makeFilter(window, n, asKernel = FALSE)
    w <- w / max(w)
    normalization <- mean(w^2)
    S <- array(NA, dim = c(length(f), nwindow))
    for (i in 1:nwindow) {
        start <- floor((i - 1) * (1 - overlap) * n) + 1
        end <- start + n - 1
        if (end > N) {
            end <- N
            start <- end - n + 1
        }
        s <- spec.pgram(w * ts(x[start:end], frequency = fs),
            plot = plot, taper = 0.1,
        )
        S[, i] <- s$spec
    }
    savg <- apply(S, 1, mean) / normalization
    s$spec <- savg
    s$method <- "Welch"
    s$series <- deparse(substitute(expr = x, env = environment()))
    s$df <- s$df * (N / n)
    s$window <- w
    return(s)
}

# x <- ts(rnorm(2056), deltat = 1)
# s <- my_pwelch(x, nwindow=8)
# plot(s)
