library(oce)
load("lt.rda")
if (!interactive()) png("874b.png")
plot(lt, band='terralook')
if (!interactive()) dev.off()

