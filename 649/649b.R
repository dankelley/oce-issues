## Try reading ODF "adcp" manually.
library(oce)
try(source("~/src/oce/R/odf.R"))
file <- "MADCPS_hud2013021_1842_3380-69_3600.ODF"
d <- read.odf(file)
if (!interactive()) png("649b.png")
par(mfrow=c(3,1))
oce.plot.ts(d[["time"]], d[["u"]])
n <- length(d[["u"]])
mtext(sprintf("%.1f percent are NA", 100*(1-sum(is.na(d[["u"]]))/n)),
      side=3, line=0, adj=1)
oce.plot.ts(d[["time"]], d[["v"]])
mtext(sprintf("%.1f percent are NA", 100*(1-sum(is.na(d[["v"]]))/n)),
      side=3, line=0, adj=1)
oce.plot.ts(d[["time"]], d[["w"]])
mtext(sprintf("%.1f percent are NA", 100*(1-sum(is.na(d[["w"]]))/n)),
      side=3, line=0, adj=1)
if (!interactive()) dev.off()
