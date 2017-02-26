rm(list=ls())
## Similar to 449c but just one panel for Dan's tired old eyes to see details.
if (!interactive()) png("449d.png", width=7, height=4, unit="in", res=150, pointsize=9)

library(oce)
par(mfcol=c(1,1), mar=c(3, 3, 1, 1))
t <- seq(0, 1, length.out=100)
plim <- c(38, 41)
p <- mean(plim) + diff(plim) / 2 * cos(2 * pi * t)
zlim <- c(38.5, 40.5)
zline <- zlim                          # seq(38.5, 40.5, 0.5)
omar <- par('mar')

par(mar=omar)
cm4 <- colormap(p, zlim=zlim, breaks=11, zclip=TRUE, debug=3, missingColor='pink')
stopifnot(!any(is.na(cm4$zcol)))
drawPalette(colormap=cm4)
plot(t, p, type='p', pch=21, cex=1.5, bg=cm4$zcol) 
abline(h=zline)
mtext("4: colormap(p, zlim, breaks=11, zclip=TRUE)", side=3, cex=3/4)
mtext("looks OK  to DK", side=3, line=-1, font=2, cex=3/4)
mtext("looks ??? to CR", side=3, line=-2, font=2, cex=3/4)
## note some messiness on the text -- easier to look at graph than in console for stuff
mtext(sprintf(" range(cm4$breaks): %.2f to %.2f", min(cm4$breaks), max(cm4$breaks)), side=1, line=-3, adj=0, font=2)
mtext(sprintf(" cm4$zlim: %.2f to %.2f", cm4$zlim[1], cm4$zlim[2]), side=1, line=-2, adj=0, font=2)
mtext(sprintf(" zlim: %.2f to %.2f", zlim[1], zlim[2]), side=1, line=-1, adj=0, font=2)

if (!interactive()) dev.off()

#message("range of p: ", min(p), " to ", max(p))
