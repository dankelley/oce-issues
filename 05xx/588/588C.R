library(oce)
f <- '050107_20130620_2245cast4.rsk'
d <- read.oce('050107_20130620_2245cast4.rsk')
if (!interactive()) png("588C_%d.png")
plotScan(d)
mtext("All data", line=0, adj=1, col='red', font=2)
plotScan(ctdTrim(d))
mtext("after ctdTrim()", line=0, adj=1, col='red', font=2)
plotScan(subset(d, 1010 < scan & scan < 1070), type='p')
mtext("after subset() to check anomaly", line=0, adj=1, col='red', font=2)
if (!interactive()) dev.off()

