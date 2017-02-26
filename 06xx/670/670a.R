library(oce)
data(ctdRaw)
TRIM <- c(200, 300)

if (!interactive()) png("670a.png")
par(mfrow=c(2,1))
plotScan(ctdRaw)
abline(v=TRIM, col='blue')
mtext("(a) ", side=3, line=0, adj=1)
mtext("EXPECT: oddness, equilibration, downcast, then upcast",
      font=2, col='magenta', adj=0, side=3, line=0)
plotScan(ctdTrim(ctdRaw, "scan", parameters=TRIM))
abline(v=TRIM, col='red')
mtext("EXPECT: trimmed to within the blue lines in (a)",
      font=2, col='magenta', adj=0, side=3, line=0)
mtext("(b) ", side=3, line=0, adj=1)
if (!interactive()) dev.off()
