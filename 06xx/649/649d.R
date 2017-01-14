## read a CTD, to check that newly-evolving code is not breaking functionality.
library(oce)
d <- read.oce(system.file("extdata", "CTD_BCD2010666_01_01_DN.ODF", package="oce"))
if (!interactive()) png("649d.png")
plot(d)
if (!interactive()) dev.off()
