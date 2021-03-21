# Demonstrate that we need keep=TRUE (which is what oce does)
library(sf)
for (lon in seq(50, 51, 0.1)) {
    cat("lon=", lon, " ... next (with keep=TRUE,warn=FALSE) works:\n")
    print(sf_project("+proj=longlat", "+proj=ortho +lon_0=-40", cbind(lon,0), keep=TRUE, warn=FALSE))
    cat("lon=", lon, " ... next (with default keep,warn) fails at lon=50.1:\n")
    print(sf_project("+proj=longlat", "+proj=ortho +lon_0=-40", cbind(lon,0)))
}

