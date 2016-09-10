library(oce)
library(mapmisc)
data(coastlineWorld)
proj <- sp::CRS("+init=epsg:3978") # CF ../1078/1078a.R
print(proj)
if (!interactive()) png("1079a.png")
par(mar=c(2, 2, 1, 1))
plot(coastlineWorld, proj=proj, span=6000)
if (!interactive()) dev.off()

