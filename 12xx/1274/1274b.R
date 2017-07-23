library(oce)
data(section)
section <- handleFlags(section)
dhu <- swDynamicHeight(section, eos="unesco")
dhg <- swDynamicHeight(section, eos="gsw")
if (!interactive()) png("1274b.png")
par(mfrow=c(2,1), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
bad <- which(abs(dhg$height) > 10)
for (b in bad) {
    cat("b=", b, " has data:\n")
    print(as.data.frame(section[["station", b]][["data"]]))
}
plot(dhg$distance, dhg$height)
points(dhu$distance,dhu$height,col=2)
mtext(paste("bad: ", paste(bad, collapse=" ")), side=3, line=0.2)
plot(dhg$distance, dhg$height, ylim=c(-1, 3.5))
points(dhu$distance,dhu$height,col=2,pch=20)
if (!interactive()) dev.off()

