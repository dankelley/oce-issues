library(oce)
options(warn=2) # convert warnings to errors, for checking
data(section)
if (!interactive()) png("1007a1.png")
plot(section)
if (!interactive()) dev.off()
for(i in seq_along(section@data$station)) {
    section@data$station[[i]]@data$salinity <- rep(NA,
          length(section@data$station[[i]]@data$salinity))
}
if (!interactive()) png("1007a2.png")
plot(section)
if (!interactive()) dev.off()

