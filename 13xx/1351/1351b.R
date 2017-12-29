rm(list=ls())
library(oce)
library(testthat)
rms <- function(x) sqrt(mean(x^2, na.rm=TRUE))
mad <- function(x) mean(abs(x), na.rm=TRUE)
medad <- function(x) median(abs(x), na.rm=TRUE)

showinferred <- function(x)
{
    abline(v=x[["frequency"]][x[["name"]]=="P1"], col="red")
    abline(v=x[["frequency"]][x[["name"]]=="K2"], col="red")
    abline(v=x[["frequency"]][x[["name"]]=="K1"], col="blue", lty=2)
    abline(v=x[["frequency"]][x[["name"]]=="S2"], col="blue", lty=2)
}
data(sealevelTuktoyaktuk)
m <- tidem(sealevelTuktoyaktuk,
           constituents=c("standard", "M10"),
           infer=list(name=c("P1","K2"),
                      from=c("K1", "S2"),
                      amp=c(0.33093, 0.27215),
                      phase=c(-7.07, -22.4)))
## summary(m)
ttide <- read.table("ttide.dat", header=TRUE, skip=8, stringsAsFactors=FALSE)
head(ttide, 3)
## use Foreman names to make comparisons easier
ttide$Tide <- gsub("^MS$", "M8", gsub("^UPSI$", "UPS1", ttide$Tide))
expect_equal(m[["name"]], ttide$Tide)
expect_equal(m[["freq"]], ttide$Freq, tol=1e-5) # ttide table e.g. 0.08333
cmp <- data.frame(name=m[["name"]],
                  frequency=m[["frequency"]],
                  ampttide=ttide$Amp,
                  amptidem=m[["amplitude"]],
                  ampdiff=ttide$Amp-m[["amplitude"]])
if (!interactive()) png("1351b.png")
par(mfrow=c(2,1), mar=c(3, 3, 2, 3), mgp=c(2, 0.7, 0))
plot(cmp$frequency, log10(cmp$ampttide), xlab="Freq", ylab="log10(Amp)", ylim=range(log10(c(cmp$ampttide, cmp$amptidem))))
axis(side=4, at=seq(-3, 0, 1), label=c("1mm", "10mm", "1cm", "1m"))
points(cmp$frequency, log10(cmp$amptidem), pch=20, col=2, cex=0.5)
showinferred(m)
legend("topright", pch=rep(1, 4), col=c(4,3,2,1),
       legend=c("Z0, given by T-TIDE to only 10mm",
                "P1 (inferred)",
                "K2 (inferred)",
                "Other components, given by T-TIDE to 0.1mm"))


z0 <- which(cmp$name=="Z0")[1]
p1 <- which(cmp$name=="P1")[1]
k2 <- which(cmp$name=="K2")[1]
points(cmp$frequency[z0], log10(cmp$amptidem[z0]), col=2, cex=2)
points(cmp$frequency[p1], log10(cmp$amptidem[p1]), col=3, cex=2)
points(cmp$frequency[k2], log10(cmp$amptidem[k2]), col=4, cex=2)

diff <- cmp$ampttide - cmp$amptidem
mtext(sprintf("All: RMS(diff)=%.2fmm; mean(abs(diff))=%.2fmm; median(abs(diff))=%.2fm",
              1000*rms(diff), 1000*mad(diff), 1000*medad(diff)), side=3)
mtext(sprintf("All but Z0: RMS(diff)=%.2fmm; mean(abs(diff))=%.2fmm; median(abs(diff))=%.2fmm",
              1000*rms(diff[-z0]), 1000*mad(diff[-z0]), 1000*medad(diff[-z0])), side=3, line=1)

plot(cmp$frequency, diff, xlab="Freq", ylab="T-Tide amp. - tidem() amp. [m]")
points(cmp$frequency[z0], diff[z0], col=2, cex=2)
points(cmp$frequency[p1], diff[p1], col=3, cex=2)
points(cmp$frequency[k2], diff[k2], col=4, cex=2)
showinferred(m)
abline(h=c(0, -0.0001, 0.0001), lty=c(1, 2, 2), col="gray") # match, +- 0.1mm
mtext("horiz dashed lines show 0.1mm resolution", side=3)
legend("topright", pch=rep(1, 4), col=c(4,3,2,1),
       legend=c("Z0, given by T-TIDE to only 10mm",
                "P1 (inferred)",
                "K2 (inferred)",
                "Other components, given by T-TIDE to 0.1mm"))

if (!interactive()) dev.off()
