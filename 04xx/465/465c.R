library(oce)
if (!exists("ns"))
    ns <- read.oce("LC80080292014129LGN00", debug=1)
D <- 0.02
ll <- list(longitude=-63.578-D/2, latitude=44.65-D/2)
ur <- list(longitude=-63.578+D/2, latitude=44.65+D/2)
halifax <- landsatTrim(ns, ll, ur)
plot(halifax)
points(-63.580511, 44.647504, pch=21, bg='yellow', cex=2) # Citadel museum
 
