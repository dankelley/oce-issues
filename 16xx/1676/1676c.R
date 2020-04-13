## Next is pretty handy, so putting it here to find it later
plotRaw <- function(buf, i, events, highlight)
{
    omar <- par("mar")
    omgp <- par("mgp")
    par(mar=c(3, 3, 2.5, 1), mgp=c(2, 0.7, 0))
    plot(i, as.integer(buf[i]), pch=".", yaxs="i",
         xlab="Buffer Index", ylab="Buffer Value (base 10)")
    n <- length(events[[1]])
    for (j in seq_len(n)) {
        rug(events$i[j], side=1, col=events$col[j], lwd=2, ticksize=-0.02)
        rug(events$i[j], side=1, col=events$col[j], lwd=2, ticksize=0.02)
        rug(events$i[j], side=3, col=events$col[j], lwd=2, ticksize=0.02)
        rug(events$i[j], side=3, col=events$col[j], lwd=2, ticksize=-0.02)
        mtext(events$label[j], side=3, at=events$i[j], col=events$col[j], line=0.5)
    }
    ih <- which(buf[i] == highlight)
    abline(v=i[ih], col="magenta", lwd=1/2)
    mtext(paste0("Highlighting where buffer is 0x", highlight), side=4, col="magenta")
    par(mar=omar, mgp=omgp)
}

library(oce)
fileSize <- 939294720
o <- seq(0, 12)
## Cache
if (!exists("buf"))
    buf <- readBin("~/Dropbox/S101135A001_Ronald.ad2cp", what="raw", n=fileSize)

dataSize <- 16032

if (!interactive()) png("1676c.png", width=7, height=3, unit="in", res=150, pointsize=9)
par(mar=c(3,3,1,1), mgp=c(2,0.7,0))

i <- 166786244 + seq(-2*dataSize, 5*dataSize)
plotRaw(buf, i=i, events=list(i=166786244+c(0,16032),
                              label=c("Start", "End"),
                              col=c("darkgreen", "red")),
                              highlight=as.raw(0xa5))

if (!interactive()) dev.off()

d <- function(i, msg="", o=seq(-3,3))
{
    cat(msg, "\n")
    data.frame(index=i+o, offset=o, buf=buf[i+o+1])
}
d(166786244, "ok")
d(166805910, "bad")
