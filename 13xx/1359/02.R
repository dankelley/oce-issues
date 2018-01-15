library(testthat)
welchCalc <- function(x, noverlap)
{
    M <- length(x)
    if (missing(noverlap)) {
        L <- floor(M / 4.5)
        noverlap <- floor(L / 2)
        if (L < 2)
            stop("too few data")
    } else {
        L <- floor((M + 7 * noverlap) / 8)
    }
    k <- (M-noverlap) / (L-noverlap)
    start <- seq(1, floor(k) * (L - noverlap), L - noverlap)
    end <- start + L - 1
    list(M=M, L=L, k=k, kint=floor(k), noverlap=noverlap, start=start, end=end)
}

x <- read.table("x1.dat")$V1
pxx <- read.table("pxx1.dat")$V1
n <- welchCalc(x)
ME <- 320
LE <- 71
noverlapE <- 35
startE <- scan(text='1  37  73 109 145 181 217', quiet=TRUE)
endE <- scan(text='71 107 143 179 215 251 287', quiet=TRUE)
expect_equal(n$M, ME)
expect_equal(n$L, LE)
expect_equal(n$noverlap, noverlapE)
expect_equal(n$start, startE)
expect_equal(n$end, endE)

segs <- length(n$start)
i <- 1
len <- 1 + n$end[1] - n$start[1]
lenlen <- 256 - len                    # FIXME
spec <- rep(0, len + lenlen)
pad <- rep(0, lenlen)
window <- signal::hamming(len)
for (i in 1:n$kint) {
    xx <- c(window*x[n$start[i]:n$end[i]], pad)
    cat("\nx=", paste((x[n$start[i]:n$end[i]])[1:5], collapse=" "), "\n")
    cat("window=", paste(window[1:5], collapse=" "), "\n")
    cat("xw=", paste((window*x[n$start[i]:n$end[i]])[1:5], collapse=" "), "\n")
    X <- fft(xx)
    pow <- Re(X * Conj(X))
    spec <- spec + pow
}
spec <- spec / n$kint / sum(window^2)
freq <- seq(0, 1, length.out=1+floor(len+lenlen)/2)
expect_equal(length(freq), 129)

## Subset spectrum and then scale it, with extra adjustment at zero frequency
## and, if the spectrum is of odd length, also at the highest of the chosen
## frequencies.
spec <- spec / pi
if ((len + lenlen) %% 2) {
    lSpec <- floor(len+lenlen)/2
    Spec <- spec[1:lSpec]
    Spec[1] <- Spec[1] / 2
} else {
    lSpec <- 1 + floor(len+lenlen)/2
    Spec <- spec[1:lSpec]
    Spec[1] <- Spec[1] / 2
    Spec[lSpec] <- Spec[lSpec] / 2
}

if (!interactive())
    png("02.png", width=7, height=5, unit="in", res=150, pointsize=9)
par(mfrow=c(2, 1), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
plot(freq, 10*log10(Spec), type='l', xaxs='i', ylim=c(-12,8), lwd=4)
grid()
lines(freq, 10*log10(pxx), col=3)
abline(v=1/4, col='red')
expect_equal(head(window, 8),
             c(0.0800000000, 0.0818518248, 0.0873923892, 0.0965770841,
               0.1093319595, 0.1255543208, 0.1451135549, 0.1678521826))

plot(freq, 1-pxx/Spec, type='l', xaxs='i')

m <- lm(Spec~pxx)
percentage <- as.vector(100*(Spec-predict(m))/Spec)
fac <- median(pxx/Spec)
expect_equal(fac, 1, label="fac")
bad <- abs((pxx-median(pxx/Spec)*Spec)/Spec)>1e-7
##plot(freq, bad)
if (sum(bad)) {
    cat("BAD:\n")
    print(data.frame(i=seq_along(bad)[bad], pxx=pxx[bad], Spec=Spec[bad], freq=freq[bad]))
} else {
    cat("AGREEMENT to factor 1e-7\n")
}

if (!interactive())
    dev.off()

