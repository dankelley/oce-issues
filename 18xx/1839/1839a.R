library(oce)
# This code started with a regexp provided by @HolgerF22.  See
# https://github.com/dankelley/oce/issues/1839 for details.

# Makes a two-panel plot. Top panel: default (i.e. detrend=TRUE). Bottom panel:
# detrend=FALSE.

set.seed(1839)                         # for reproducibility
l <- 50000
f_s <- 250
t <- ((1:l)/f_s - 1/f_s)

noise <- rnorm(l)
noisevar <- 0.1

A1 <- 0.5*sqrt(2)
A2 <- 1.0*sqrt(2)
A3 <- 1.25*sqrt(2)

s  <-  A1*cos(2*pi*t*2) + A2*cos(2*pi*t*5) + A3*cos(2*pi*8*t) +
sqrt(noisevar)*noise

xts <- ts(s/20e-6, start=0, frequency=f_s)

nf <- 8192

if (!interactive()) png("1839a.png", unit="in", width=7, height=5, res=120, pointsize=11)

par(mfrow=c(2,1), mar=c(3.5,3.5,3,1), mgp=c(2,0.7,0))

psd <- pwelch(xts,nfft=nf,fs=f_s,plot=FALSE)
plot(psd$freq,10*log10(psd$spec),type='l',log='x',xlim = c(0.01,f_s/2),ylim=c(50,120),
     xlab="Frequency [Hz]", ylab="Power [dB]")
mtext("https://github.com/dankelley/oce-issues/blob/main/18xx/1839/1839a.R", col=2, line=1.5)
mtext("detrend not supplied (defaults to TRUE)")

psd <- pwelch(xts,nfft=nf,fs=f_s,plot=FALSE,detrend=FALSE)
plot(psd$freq,10*log10(psd$spec),type='l',log='x',xlim = c(0.01,f_s/2),ylim=c(50,120),
     xlab="Frequency [Hz]", ylab="Power [dB]")
mtext("detrend=FALSE")

if (!interactive()) dev.off()
