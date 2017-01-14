library(oce)
## try(source("~/src/oce/R/topo.R"))
topo <- read.topo('AsiaTopo.asc')
if (!interactive()) png("544.png")
plot(topo)
if (!interactive()) dev.off()

