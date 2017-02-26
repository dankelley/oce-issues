library(oce)
library(testthat)
file <- "MS2015-150kHz002_000001.ENX"
if (1 == length(list.files(pattern="*.ENX"))) {
    d <- read.adp.rdi(file,
                      from=as.POSIXct("2015-09-19 14:00:00", tz="UTC"),
                      to=as.POSIXct("2015-09-19 14:30:00", tz="UTC"),
                      latitude =49.303950 ,longitude =-67.387133)#, debug=3)
    dataNames <- names(d@data)
    expect_true('br' %in% dataNames, info="This file should have bottom range, br")
    expect_true('bv' %in% dataNames, info="This file should have bottom velocity, bv")
    expect_true('firstLongitude' %in% dataNames, info="This file should [[\"firstLongitude\"]]")
    expect_true('firstLatitude' %in% dataNames, info="This file should [[\"firstLatitude\"]]")
    expect_true('lastLongitude' %in% dataNames, info="This file should [[\"lastLongitude\"]]")
    expect_true('lastLatitude' %in% dataNames, info="This file should [[\"lastLatitude\"]]")
    lat <- d[['firstLatitude']]
    lon <- d[['firstLongitude']]
    data(coastlineWorldFine, package="ocedata")
    if (!interactive()) png("777a.png")
    par(mfrow=c(2,1))
    plot(coastlineWorldFine, clon=mean(lon), clat=mean(lat), span=130)
    lines(lon, lat, col='red')
    plot(coastlineWorldFine, clon=mean(lon), clat=mean(lat), span=30)
    lines(lon, lat, col='red')
    if (!interactive()) dev.off()
} else {
    message("cannot run the test in 777a.R because it needs a file named ", file)
}
