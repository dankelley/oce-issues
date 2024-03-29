if (!interactive()) png("434.png", width=5, height=3, unit="in", res=150, pointsize=9)

library(oce)
data(topoWorld)
cm <- colormap(name="gmt_globe", debug=3)
imagep(topoWorld, breaks=cm$breaks, col=cm$col)
mtext("EXPECT: reasonable coastline e.g. Hudsons Bay", font=2, col='purple')
if (!interactive()) dev.off()

