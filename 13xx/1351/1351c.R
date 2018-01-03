rm(list=ls())
detailed <- FALSE
library(oce)
library(testthat)

showInferred <- function(x)
{
    abline(v=x[["frequency"]][x[["name"]]=="P1"], lty=3)
    abline(v=x[["frequency"]][x[["name"]]=="K2"], lty=3)
    ##abline(v=x[["frequency"]][x[["name"]]=="K1"], col="gray", lty=2)
    ##abline(v=x[["frequency"]][x[["name"]]=="S2"], col="gray", lty=2)
    ##mtext("P1      ", at=x[["frequency"]][x[["name"]]=="P1"],
    ##      side=1, line=-1, cex=0.8, font=3)
    ##mtext("      K2", at=x[["frequency"]][x[["name"]]=="K2"],
    ##      side=1, line=-1, cex=0.8, font=3)
}

showDiffs <- function(diff)
{
    rms <- function(x) sqrt(mean(x^2, na.rm=TRUE))
    mad <- function(x) mean(abs(x), na.rm=TRUE)
    medad <- function(x) median(abs(x), na.rm=TRUE)
    mtext(sprintf("rms diff %.2fmm ", round(1000*rms(diff), 2)), line=-3, adj=1, side=1, cex=0.7)
    mtext(sprintf("mean |diff| %.2fmm ", round(1000*mad(diff), 2)), line=-2, adj=1, side=1, cex=0.7)
    mtext(sprintf("median |diff| %.2fmm ", round(1000*medad(diff), 2)), line=-1, adj=1, side=1, cex=0.7)
}

showLegend <- function()
{
    legend("topright", pch=1, col=c(6,5,4,3), pt.lwd=1.5,
           legend=c("S2", "K2", "K1", "P1"))
}

foreman <- read.table("foreman.dat", header=TRUE, stringsAsFactors=FALSE)
ttide <- read.table("ttide.dat", header=TRUE, skip=8, stringsAsFactors=FALSE)
## switch T_TIDE to Foreman names (which tidem() also uses)
ttide$name <- gsub("^MS$", "M8", gsub("^UPSI$", "UPS1", ttide$name))

data(sealevelTuktoyaktuk)
m <- tidem(sealevelTuktoyaktuk,
           constituents=c("standard", "M10"),
           infer=list(name=c("P1", "K2"), # 0.0415525871 0.0835614924
                      from=c("K1", "S2"), # 0.0417807462 0.0833333333
                      amp=c(0.33093, 0.27215),
                      phase=c(-7.07, -22.40)), debug=0)

## 1. are constituents in the relationship implied by the following code
##    from t_demo.m?
##         infername=['P1';'K2'];
##         inferfrom=['K1';'S2'];
##         infamp=[.33093;.27215];
##         infphase=[-7.07;-22.40]

## Amplitude
expect_equal(ttide[ttide$name=="P1", "amplitude"],
             .33093*ttide[ttide$name=="K1", "amplitude"], tol=1e-5) # amp P1 from K1
expect_equal(ttide[ttide$name=="K2", "amplitude"],
             .27215*ttide[ttide$name=="S2", "amplitude"], tol=1e-5) # amp P1 from K1
## Phase
expect_equal(ttide[ttide$name=="P1", "phase"],
             ttide[ttide$name=="K1", "phase"] - (-7.07), tol=1e-5) # amp P1 from K1
expect_equal(ttide[ttide$name=="K2", "phase"],
             ttide[ttide$name=="S2", "phase"] - (-22.40), tol=1e-5) # amp P1 from K1

## some constituents that differ a lot between ttide and tidem
p1 <- which(foreman$name=="P1")[1]
k1 <- which(foreman$name=="K1")[1]
k2 <- which(foreman$name=="K2")[1]
s2 <- which(foreman$name=="S2")[1]

##> These two tests are now in tests/testthat/test_tidem.R
##> ## 2. do ttide and foreman frequencies match?
##> expect_equal(ttide$name, foreman$name)
##> expect_equal(ttide$frequency, foreman$frequency, tol=5e-6) # T_TIDE reports to 1e-5

if (!interactive()) png("1351c.png", height=4, width=7, unit="in", res=150, pointsize=10)
par(mfcol=c(2,4), mar=c(3, 3, 2, 3), mgp=c(2, 0.7, 0))

## LEFT PANELS: Foreman "A" vs T_TIDE amplitude
## LEFT TOP: value
plot(ttide$frequency, log10(foreman$A), xlab="Frequency", ylab="log10(amp)")
mtext("Foreman A vs T_TIDE", side=3, cex=0.9, line=0.5)
showInferred(foreman)
points(foreman$frequency[p1], log10(foreman$A[p1]), col=3, lwd=2)
points(foreman$frequency[k1], log10(foreman$A[k1]), col=4, lwd=2)
points(foreman$frequency[k2], log10(foreman$A[k2]), col=5, lwd=2)
points(foreman$frequency[s2], log10(foreman$A[s2]), col=6, lwd=2)
points(ttide$frequency, log10(ttide$amplitude), pch="+")
axis(side=4, at=seq(-3, 0, 1), label=c("1mm", "10mm", "1cm", "1m"))
showLegend()
## LEFT BOTTOM: difference
diff <- foreman$A - ttide$amplitude
ylim <- c(-1,1)*max(abs(diff), na.rm=TRUE)
plot(foreman$frequency, diff, ylim=ylim,
     xlab="Freq", ylab="Foreman-Ttide amp. [m]")
showInferred(foreman)
points(foreman$frequency[p1], diff[p1], col=3, lwd=2)
points(foreman$frequency[k1], diff[k1], col=4, lwd=2)
points(foreman$frequency[k2], diff[k2], col=5, lwd=2)
points(foreman$frequency[s2], diff[s2], col=6, lwd=2)
abline(h=c(0, -0.0001, 0.0001), lty=c(1, 2, 2), col="gray") # match, +- 0.1mm
showDiffs(diff)
showLegend()

## LEFT-MIDDLE PANELS: Foreman "AL" vs T_TIDE amplitude
## LEFT-MIDDLE TOP: value
plot(ttide$frequency, log10(foreman$AL), xlab="Frequency", ylab="log10(amp)")
mtext("Foreman AL vs T_TIDE", side=3, cex=0.9, line=0.5)
showInferred(foreman)
points(foreman$frequency[p1], log10(foreman$AL[p1]), col=3, lwd=2)
points(foreman$frequency[k1], log10(foreman$AL[k1]), col=4, lwd=2)
points(foreman$frequency[k2], log10(foreman$AL[k2]), col=5, lwd=2)
points(foreman$frequency[s2], log10(foreman$AL[s2]), col=6, lwd=2)
points(ttide$frequency, log10(ttide$amplitude), pch="+")
axis(side=4, at=seq(-3, 0, 1), label=c("1mm", "10mm", "1cm", "1m"))
showLegend()
## LEFT-MIDDLE BOTTOM: difference
diff <- foreman$AL - ttide$amplitude
ylim <- c(-1,1)*max(abs(diff), na.rm=TRUE)
plot(foreman$frequency, diff, ylim=ylim,
     xlab="Freq", ylab="Foreman-Ttide amp. [m]")
showInferred(foreman)
points(foreman$frequency[p1], diff[p1], col=3, lwd=2)
points(foreman$frequency[k1], diff[k1], col=4, lwd=2)
points(foreman$frequency[k2], diff[k2], col=5, lwd=2)
points(foreman$frequency[s2], diff[s2], col=6, lwd=2)
abline(h=c(0, -0.0001, 0.0001), lty=c(1, 2, 2), col="gray") # match, +- 0.1mm
showDiffs(diff)
showLegend()

## RIGHT-MIDDLE PANELS: Foreman "A" vs tidem() amplitude
## RIGHT-MIDDLE TOP: value
ylim <- range(log10(c(ttide$amplitude, m[["amplitude"]])))
plot(ttide$frequency, log10(ttide$amplitude), ylim=ylim, xlab="Frequency", ylab="log10(amp)")
mtext("T_TIDE vs tidem", side=3, cex=0.9, line=0.5)
points(ttide$frequency, log10(m[["amplitude"]]), pch='+')
points(ttide$frequency[p1], (ttide$amplitude-m[["amplitude"]])[p1], col=3, lwd=2)
points(ttide$frequency[k1], (ttide$amplitude-m[["amplitude"]])[k1], col=4, lwd=2)
points(ttide$frequency[k2], (ttide$amplitude-m[["amplitude"]])[k2], col=5, lwd=2)
points(ttide$frequency[s2], (ttide$amplitude-m[["amplitude"]])[s2], col=6, lwd=2)
axis(side=4, at=seq(-3, 0, 1), label=c("1mm", "10mm", "1cm", "1m"))
showInferred(foreman)
showLegend()
## RIGHT-RIGHT BOTTOM: difference
diff <- ttide$amplitude - round(m[["amplitude"]], 4)
ylim <- c(-1,1)*max(abs(diff), na.rm=TRUE)
plot(foreman$frequency, diff, ylim=ylim,
     xlab="Freq", ylab="tidem - T_TIDE [m]")
showInferred(foreman)
points(foreman$frequency[p1], diff[p1], col=3, lwd=2)
points(foreman$frequency[k1], diff[k1], col=4, lwd=2)
points(foreman$frequency[k2], diff[k2], col=5, lwd=2)
points(foreman$frequency[s2], diff[s2], col=6, lwd=2)
abline(h=c(0, -0.0001, 0.0001), lty=c(1, 2, 2), col="gray") # match, +- 0.1mm
showDiffs(diff)
showLegend()

## RIGHT PANELS: Foreman vs tidem() amplitude
## RIGHT TOP: value
plot(foreman$frequency, log10(foreman$A), xlab="Frequency", ylab="log10(amp)")
mtext("Foreman A vs tidem", side=3, cex=0.9, line=0.5)
showInferred(foreman)
points(foreman$frequency[p1], log10(foreman$A[p1]), col=3, lwd=2)
points(foreman$frequency[k1], log10(foreman$A[k1]), col=4, lwd=2)
points(foreman$frequency[k2], log10(foreman$A[k2]), col=5, lwd=2)
points(foreman$frequency[s2], log10(foreman$A[s2]), col=6, lwd=2)
amp <- round(m[["amplitude"]], 4) ## round to match Foreman App 7.3 (1977) and Pawlowicz et al. (2002) table 1
points(foreman$frequency, log10(amp), pch="+")
axis(side=4, at=seq(-3, 0, 1), label=c("1mm", "10mm", "1cm", "1m"))
showLegend()
## RIGHT BOTTOM: difference
diff <- foreman$A - amp
ylim <- c(-1,1)*max(abs(diff), na.rm=TRUE)
plot(foreman$frequency, diff, ylim=ylim,
     xlab="Freq", ylab="Ttide-tidem amp. [m]")
showInferred(foreman)
points(foreman$frequency[p1], diff[p1], col=3, lwd=2)
points(foreman$frequency[k1], diff[k1], col=4, lwd=2)
points(foreman$frequency[k2], diff[k2], col=5, lwd=2)
points(foreman$frequency[s2], diff[s2], col=6, lwd=2)
abline(h=c(0, -0.0001, 0.0001), lty=c(1, 2, 2), col="gray") # match, +- 0.1mm
showDiffs(diff)
showLegend()

if (!interactive()) dev.off()

# Did inference formula work?
expect_equal(0.33093,
             m[["amplitude"]][which(m[["name"]]=="P1")]/m[["amplitude"]][which(m[["name"]]=="K1")])
expect_equal(m[["phase"]][which(m[["name"]]=="P1")],
             m[["phase"]][which(m[["name"]]=="K1")]-(-7.07))
expect_equal(0.27215,
             m[["amplitude"]][which(m[["name"]]=="K2")]/m[["amplitude"]][which(m[["name"]]=="S2")])
expect_equal(m[["phase"]][which(m[["name"]]=="K2")],
             m[["phase"]][which(m[["name"]]=="S2")]-(-22.40))

##summary(m)

if (detailed) {
    cat("Three points differ between T_TIDE and Foreman\n")
    for (check in c("K1", "S2", "K2")) {
        print(ttide[ttide$name==check, c("name", "frequency", "amplitude")])
        print(foreman[foreman$name==check, c("name", "frequency", "A")])
    }
}

cat("Three points differ between T_TIDE (first in pairs below) and tidem (second).\n")
df <- data.frame(name=m[["name"]], frequency=m[["frequency"]], amplitude=m[["amplitude"]])
for (check in c("K1", "P1", "S2")) {
    print(ttide[ttide$name==check, c("name", "frequency", "amplitude")])
}
name <- c("K1", "P1", "K2", "S2")
df <- data.frame(name=name,
                 freq=unlist(lapply(name, function(n) ttide$freq[which(ttide$name==n)])),
                 ForemanAmp=unlist(lapply(name, function(n) foreman$A[which(foreman$name==n)])),
                 ForemanPhase=unlist(lapply(name, function(n) foreman$G[which(foreman$name==n)])),
                 TTIDEAmp=unlist(lapply(name, function(n) ttide$amplitude[which(ttide$name==n)])),
                 TTIDEPhase=unlist(lapply(name, function(n) ttide$phase[which(ttide$name==n)])),
                 tidemAmp=unlist(lapply(name, function(n) round(m[["amplitude"]][which(m[["name"]]==n)],4))),
                 tidemPhase=unlist(lapply(name, function(n) round(m[["phase"]][which(m[["name"]]==n)],4))))
print(df)

