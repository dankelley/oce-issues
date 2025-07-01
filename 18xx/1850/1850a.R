# As of 2025-07-01l this requires oce "develop" branch commit
# b71a2e3658215e8a134073508d19bc5910da5134 or later
#
library(oce)
# https://www.naturalearthdata.com/downloads/110m-physical-vectors/ Note that
# there are 'land' and 'coastline' files. Not sure which we might want but all
# that I care about now is reading the data.
file <- "ne_110m_land.shp"
t1 <- system.time({
    for (i in 1:100) {
        d <- read.oce(file)
    }
})
t2 <- system.time({
    for (i in 1:100) {
        cl <- as.coastline(longitude = d[["longitude"]], latitude = d[["latitude"]])
    }
})

# CL <- read.coastline(file, debug=3)
if (!interactive()) {
    png("1850a_%02d.png", units = "in", width = 7, height = 7, res = 200)
}

par(mfrow = c(2, 1))
plot(cl)
CL <- read.coastline(file) # requires updated oce
plot(CL)

if (!interactive()) {
    dev.off()
}

summary(cl)
summary(CL)


cat("Reading the shapefile took time: \n")
print(t1 / 100)
cat("Converting the shapefile to a coastline took time\n")
print(t2 / 100)
