rm(list=ls())
library(oce)
library(testthat)
showinferred <- function(x)
{
    abline(v=x[["frequency"]][x[["name"]]=="P1"], col="red")
    abline(v=x[["frequency"]][x[["name"]]=="K2"], col="red")
    abline(v=x[["frequency"]][x[["name"]]=="K1"], col="blue", lty=2)
    abline(v=x[["frequency"]][x[["name"]]=="S2"], col="blue", lty=2)
}
data(sealevelTuktoyaktuk)
m <- tidem(sealevelTuktoyaktuk, constituents=c("standard", "P1", "K2", "M10"))
## summary(m)
ttide <- read.table("ttide.dat", header=TRUE, skip=8, stringsAsFactors=FALSE)
head(ttide, 3)
## use Foreman names to make comparisons easier
ttide$Tide <- gsub("^MS$", "M8", gsub("^UPSI$", "UPS1", ttide$Tide))
expect_equal(m[["name"]], ttide$Tide)
expect_equal(m[["freq"]], ttide$Freq, tol=1e-5) # ttide table e.g. 0.08333
cmp <- data.frame(frequency=m[["frequency"]],
                  ampttide=ttide$Amp,
                  amptidem=m[["amplitude"]],
                  ampdiff=ttide$Amp-m[["amplitude"]])
if (!interactive()) png("1351b.png")
par(mfrow=c(2,1), mar=c(3, 3, 1, 3), mgp=c(2, 0.7, 0))
plot(cmp$frequency, log10(cmp$ampttide), xlab="Freq", ylab="log10(TTIDE Amp)", ylim=range(log10(c(cmp$ampttide, cmp$amptidem))))
axis(side=4, at=seq(-3, 0, 1), label=c("1mm", "10mm", "1cm", "1m"))
points(cmp$frequency, log10(cmp$amptidem), pch="+", col=2)
showinferred(m)

plot(cmp$frequency, cmp$ampttide-cmp$amptidem, xlab="Freq", ylab="Amp diff [m]")
showinferred(m)
abline(h=c(0, -0.001, 0.001), col="gray") # match, +- 1mm

if (!interactive()) dev.off()
