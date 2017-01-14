## read a CTD, to check that newly-evolving code is not breaking functionality.
library(oce)
d <- read.oce("MCM_HUD2013021_1840_2415_300.ODF")
if (!interactive()) png("649e.png")
plot(d)
if (!interactive()) dev.off()
