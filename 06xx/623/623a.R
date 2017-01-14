library(oce)
try(source("~/src/oce/R/ctd.R"))
d <- read.oce("a.rsk")
dt <- ctdTrim(d)
dd <- d
dd[["pressure"]] <- dd[["pressure"]] - 10.3
ddt <- ctdTrim(dd)

if (!interactive()) png("623a_%d.png")
plot(dt)
title("ctdTrim() with uncorrected pressure")
plotScan(dt)
title("ctdTrim() with uncorrected pressure")
plot(ddt)
title("ctdTrim() after subtracting 10.3")
plotScan(ddt)
title("ctdTrim() after subtracting 10.3")

if (!interactive()) dev.off()

