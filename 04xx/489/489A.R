rm(list=ls())
library(oce)
data(adp)
t <- adp[['time']]
d <- adp[['distance']]
spd <- sqrt(adp[['v']][,,1]^2 + adp[['v']][,,2]^2)
spd[10:40, 1:30] <- 0
spd[10:40, 60:84] <- 1.3

if (!interactive()) png('489A_%d.png', width=7, height=5, unit="in", 
                        res=100, pointsize=8, type='cairo', antialias='none')

par(mfrow=c(2,2), mar=c(3, 3, 5, 1))

col <- colorRampPalette(c("white", "#ffe45e", "#FF7F00", "red", "#7F0000"))
breaks <- seq(0, 1.5, 0.2)
cm <- colormap(spd, breaks=breaks, col=col)

imagep(t, d, spd, colormap=cm, filledContour=TRUE,
       mar=c(2, 2, 2, 0.5), drawTimeRange=FALSE)
oceContour(t, d, spd, levels=breaks[2], add=TRUE)
mtext("EXPECT: white/brickred box at bottom/top",
      adj=0, col="purple", font=2, cex=1)
mtext("(a) ", adj=1)

#imagep(z=spd, col=col, filledContour=TRUE, breaks=breaks,
imagep(t, d, spd, col=col, filledContour=TRUE, breaks=breaks,
       missingColor="grey",
       mar=c(2, 2, 2, 0.5), drawTimeRange=FALSE, debug=0)
oceContour(t, d, spd, levels=breaks[2], add=TRUE)
mtext("EXPECT: same as (a)", adj=0, col="purple", font=2)
mtext("(b) ", adj=1)

## Now for non-filled-contour cases
imagep(t, d, spd, colormap=cm, missingColor="grey",
       mar=c(2, 2, 2, 0.5), drawTimeRange=FALSE)
oceContour(t, d, spd, levels=breaks[2], add=TRUE)
mtext("EXPECT: same as (a)",
      adj=0, col="purple", font=2)
mtext("(c) ", adj=1)

imagep(t, d, spd, col=col, breaks=breaks, missingColor="grey",
       mar=c(2, 2, 2, 0.5), drawTimeRange=FALSE, debug=0)
oceContour(t, d, spd, levels=breaks[2], add=TRUE)
mtext("EXPECT: same as (a)", adj=0, col="purple", font=2)
mtext("(d) ", adj=1)

## test where x is not time
x <- seq_along(t)
y <- seq_along(d)
imagep(x, y, spd, colormap=cm, filledContour=TRUE,
       mar=c(2, 2, 2, 0.5), drawTimeRange=FALSE)
oceContour(x, y, spd, levels=breaks[2], add=TRUE)
mtext("EXPECT: white/brickred box at bottom/top",
      adj=0, col="purple", font=2, cex=1)
mtext("(a) ", adj=1)

#imagep(z=spd, col=col, filledContour=TRUE, breaks=breaks,
imagep(x, y, spd, col=col, filledContour=TRUE, breaks=breaks,
       missingColor="grey",
       mar=c(2, 2, 2, 0.5), drawTimeRange=FALSE, debug=0)
oceContour(x, y, spd, levels=breaks[2], add=TRUE)
mtext("EXPECT: same as (a)", adj=0, col="purple", font=2)
mtext("(b) ", adj=1)

## Now for non-filled-contour cases
imagep(x, y, spd, colormap=cm, missingColor="grey",
       mar=c(2, 2, 2, 0.5), drawTimeRange=FALSE)
oceContour(x, y, spd, levels=breaks[2], add=TRUE)
mtext("EXPECT: same as (a)",
      adj=0, col="purple", font=2)
mtext("(c) ", adj=1)

imagep(x, y, spd, col=col, breaks=breaks, missingColor="grey",
       mar=c(2, 2, 2, 0.5), drawTimeRange=FALSE, debug=0)
oceContour(x, y, spd, levels=breaks[2], add=TRUE)
mtext("EXPECT: same as (a)", adj=0, col="purple", font=2)
mtext("(d) ", adj=1)


if (!interactive()) dev.off()
