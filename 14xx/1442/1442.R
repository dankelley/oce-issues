library(oce)
data(section)
if (!interactive()) png("1442.png")
par(mfrow=c(2,2))
for (i in c(10, 20, 50, 100)) {
    stn <- section[["station", i]]
    plot(stn, which="density+N2", eos="unesco")
    N2gsw <- swN2(stn, eos="gsw")
    lines(N2gsw, stn[["pressure"]], col="darkgreen")
    mtext(paste("stn", i), side=1, line=-1, cex=2/3)
    mtext("unesco", side=1, line=-2, cex=2/3, col="red")
    mtext("gsw", side=1, line=-3, cex=2/3, col="darkgreen")
}
if (!interactive()) dev.off()
