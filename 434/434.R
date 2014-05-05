if (!interactive()) png("434.png", width=7, height=7, unit="in", res=150, pointsize=12)

library(oce)
data(topoWorld)
source('~/src/oce/R/colors.R')
cm <- Colormap(name="gmt_globe", debug=3)
imagep(topoWorld, breaks=cm$breaks, col=cm$col)

if (!interactive()) dev.off()

