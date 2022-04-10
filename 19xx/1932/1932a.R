if (!interactive())
    png("1932a.png")
library(oce)
data(section)
ctd <- section[["station", 100]]
plotProfile(ctd, xtype="CT", ytype="sigma0", type="o")
lines(ctd[["CT"]], ctd[["sigmaTheta"]], col=2)
lines(ctd[["CT"]], ctd[["sigma0"]], col=3)
RMS <- function(x) sqrt(mean(x^2))
mtext(paste("RMS(sigmaTheta-sigma0)=",
        RMS(ctd[["sigmaTheta"]]-ctd[["sigma0"]])),
    side=3, line=-3, col=2)
if (!interactive())
    dev.off()

