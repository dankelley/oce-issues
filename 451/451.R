if (!interactive()) png("451.png", width=7, height=4, unit="in", res=150, pointsize=9)
library(oce)
try(source('~/src/oce/R/colors.R'), silent=TRUE)
omar <- par('mar') # helps in interactive testing, repeating a source() on this file
cm <- colormap(name="gmt_globe")
drawPalette(colormap=cm)
plot(seq_along(cm$breaks), cm$breaks, pch=20, cex=2, col=cm$col,
     xlab="Palette index", ylab="Palette breaks")
par(mar=omar)                      # reset margin
if (!interactive()) dev.off()
