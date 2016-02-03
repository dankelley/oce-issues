library(oce)
try(source("~/src/oce/R/coastline.R"))
data(coastlineWorld)
if (!interactive()) png("774a.png")
par(mfrow=c(3,2))

cex <- 0.8
plot(coastlineWorld)
mtext("EXPECT: gray fill, black border", side=3, font=2, col='magenta', adj=0, cex=cex)

plot(coastlineWorld, col=NULL)
mtext("EXPECT: no fill, black borders", side=3, font=2, col='magenta', adj=0, cex=cex)

plot(coastlineWorld, col='pink')
mtext("EXPECT: pink fill, black borders", side=3, font=2, col='magenta', adj=0, cex=cex)

plot(coastlineWorld, border="blue", col=NULL)
mtext("EXPECT: no fill, blue borders", side=3, font=2, col='magenta', adj=0, cex=cex)

## compatability mode 1
plot(coastlineWorld, fill=FALSE)
mtext("EXPECT: no fill, brown borders", side=3, font=2, col='magenta', adj=0, cex=cex)

## compatability mode 2
plot(coastlineWorld, fill=TRUE)
mtext("EXPECT: lightgray fill, brown borders", side=3, font=2, col='magenta', adj=0, cex=cex)

if (!interactive()) dev.off()
