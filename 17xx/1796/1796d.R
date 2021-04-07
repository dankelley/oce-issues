library(oce)
z <- volcano
if (!interactive()) png("1796d.png")
par(mar=c(3.5,3.5,2,1))
cm <- colormap(breaks=pretty(z, 10), col=oceColorsViridis)
drawPalette(colormap=cm)
image(volcano, breaks=cm$breaks, col=cm$col)
mtext("case A: breaks and col")
if (!interactive()) dev.off()

