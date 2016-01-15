library(oce)
try(source("~/src/oce/R/ctd.R"))
try(source("~/src/oce/R/coastline.R"))
data(ctd)
Hlon <- -157.8
Hlat <- 21.2 - 0.2
ctd[["longitude"]] <- Hlon
ctd[["latitude"]] <- Hlat
if (!interactive()) png("818a.png")
par(mfrow=c(2,2))
for (dlon in c(-0.2, 0.2)) {
    for (dlat in c(-0.2, 0.2)) {
        ctd[["latitude"]] <- Hlat + dlat
        ctd[["longitude"]] <- Hlon + dlon
        plot(ctd, which='map')
    }
}
if (!interactive()) dev.off()

