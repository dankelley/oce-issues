library(oce)
library(argoFloats)

d <- getIndex() |>
    subset(ID = 6902967) |>
    getProfiles(quiet = FALSE) |>
    readProfiles(quiet = FALSE) |>
    _[["argos"]] |>
    lapply(as.ctd, profile = 1)

if (!interactive()) png("2297a.png")
plot(d[[1]])
if (!interactive()) dev.off()
