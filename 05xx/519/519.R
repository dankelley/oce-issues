if (!interactive()) png("519.png")
library(oce)
par(mfrow=c(2,1))
f <- "/data/archive/landsat/LE71910202005194ASN00"
i <- read.landsat(f, band="tirs1")
T <- i[["temperature", TRUE]]
imagep(T, asp=1)
mtext("EXPECT: temperature plot", col="purple", font=2, adj=0)
mtext("landsat 7", adj=1)
if (max(dim(T)) > 900) stop("did not decimate temperature correctly")

f <- "/data/archive/landsat/LC80070292014170LGN00"
i <- read.landsat(f, band="tirs1")
T <- i[["temperature", TRUE]]
imagep(T, asp=1)
mtext("EXPECT: temperature plot", col="purple", font=2, adj=0)
mtext("landsat 8", adj=1)
if (max(dim(T)) > 900) stop("did not decimate temperature correctly")
if (!interactive()) dev.off()


