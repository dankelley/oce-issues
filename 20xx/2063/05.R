# 05.R
library(oce)
f <- "R6990512_001.nc"
a <- read.oce(f)
ctd <- as.ctd(a)
str(ctd@metadata)
str(ctd@data)
summary(ctd)
#png("04.png")
#oce.plot.ts(a[["time"]] + 86400 * a[["mtime"]], a[["pressure"]], type="p", pch=20)
#abline(v=a[["time"]])
