library(oce)
data(section)
if (!interactive()) png("996a.png")
plot(section, which="temperature")
plot(section, which="salinity", col='red', add=TRUE)
if (!interactive()) dev.off()

