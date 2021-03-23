library(oce)
library(ocedata)
data(levitus)
if (!interactive()) png("1779a.png")
imagep(levitus$SST, colormap=colormap(levitus$SST))
msg <- "Q: is this Viridis or jet? (Want Viridis)"
mtext(msg)
message(msg)
if (!interactive()) dev.off()

