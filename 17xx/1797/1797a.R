# Top: section with CTDs containing waterDepth, so bottom is shown in grey.
# Bottom panel: a section made from argo data, so bottom is shown.
library(oce)
data(section)
library(argoFloats)
a <- readProfiles(getProfiles(subset(subset(getIndex(age=10), ID=6901191), cycle=1:10)))
sec <- as.section(a[["argos"]])
summary(sec)
if (!interactive()) png("1791a.png")
par(mfrow=c(2, 1))
plot(section, which="temperature", ylim=c(5000, 0), showBottom=TRUE)
plot(sec, which="temperature", ylim=c(3000, 0), showBottom=TRUE)
if (!interactive()) dev.off()

