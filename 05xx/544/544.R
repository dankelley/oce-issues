library(oce)
topo <- read.topo('AsiaTopo.asc')
if (!interactive()) png("544.png")
plot(topo)
if (!interactive()) dev.off()

