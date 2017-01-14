library(oce)
data(coastlineWorld)
if (!interactive()) png("774a.png", width=7, height=7, unit="in", res=100, pointsize=10)
par(mfrow=c(4,2))

cex <- 0.8
plot(coastlineWorld)
mtext("1. EXPECT: gray fill, black border", side=3, font=2, col='magenta', adj=0, cex=cex)

plot(coastlineWorld, col=NULL)
mtext("2. EXPECT: no fill, black borders", side=3, font=2, col='magenta', adj=0, cex=cex)

plot(coastlineWorld, col='pink')
mtext("3. EXPECT: pink fill, black borders", side=3, font=2, col='magenta', adj=0, cex=cex)

plot(coastlineWorld, border="blue", col=NULL)
mtext("4. EXPECT: no fill, blue borders", side=3, font=2, col='magenta', adj=0, cex=cex)

## compatability mode 1
plot(coastlineWorld, border='red', fill=FALSE)
mtext("5. EXPECT: no fill, red borders", side=3, font=2, col='magenta', adj=0, cex=cex)

## compatability mode 2
plot(coastlineWorld, border='red', fill=TRUE)
mtext("6. EXPECT: lightgray fill, red borders", side=3, font=2, col='magenta', adj=0, cex=cex)

plot(coastlineWorld, projection="+proj=moll", fill=TRUE)
mtext("7. EXPECT: lightgray fill, black borders", side=3, font=2, col='magenta', adj=0, cex=cex)

plot(coastlineWorld, col='pink', projection="+proj=moll")
mtext("7. EXPECT: pink fill, black borders", side=3, font=2, col='magenta', adj=0, cex=cex)

if (!interactive()) dev.off()
