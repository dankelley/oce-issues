library(oce)
file <- "GL_PR_PF_4902489.nc"
#source("copernicus.R")
a <- read.argo.copernicus(file, debug=2)
col <- 4
pch <- 20
cex <- 0.3
if (!interactive())
    png("1934a.png")
par(mfrow=c(3,2))
plot(a, which="map", type="o", cex=cex, col=col, pch=pch)
plot(a, which="TS", col=col, pch=pch, cex=cex)
plot(a, which="salinity profile", col=col, pch=pch, cex=cex, type="p")
plot(a, which="salinity ts", col=col, pch=pch, cex=cex)
plot(a, which="temperature profile", col=col, pch=pch, cex=cex, type="p")
plot(a, which="temperature ts", col=col, cex=cex, pch=pch)
if (!interactive())
    dev.off()

