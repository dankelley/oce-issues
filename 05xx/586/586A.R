library(oce)
data(adp)
if (!interactive()) png("586A.png")
plot(adp, which=1, breaks=seq(-1, 1, 0.5), xlim=range(adp[['time']]), drawTimeRange=FALSE)
mtext("Expect: colour levels at -1, -0.5, 0, 0.5 and 1", font=2, col='magenta', adj=0)
if (!interactive()) dev.off()
