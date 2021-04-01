# Top: section with CTDs containing waterDepth, so bottom is shown in grey.
# Bottom panel: resulf from as.section() with first 50 stations.
library(oce)
data(section)
if (!interactive()) png("1791b.png")
par(mfrow=c(2, 1))
plot(section, which="temperature", ylim=c(5000, 0), showBottom=TRUE)
ctds <- section[["station"]][1:50]
sec2 <- as.section(ctds)
plot(sec2, which="temperature", ylim=c(5000, 0), showBottom=TRUE)
if (!interactive()) dev.off()

