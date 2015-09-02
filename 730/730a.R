if (length(list.files(pattern="MADCPS_hud2013021_1841_3367-48_3600.ODF"))) {
    library(oce)
    library(testthat)
    try(source("~/src/oce/R/odf.R"))
    source("read_ODF.R")
    source("define_ODF_header.R")
    d <- read_odf("MADCPS_hud2013021_1841_3367-48_3600.ODF")
    dd <- ODF2oce(d)
    expect_equal(names(dd@data), c("u", "v", "w", "error", "a", "g", "time"))
} else {
    message("729a.R requires a file named MADCPS_hud2013021_1841_3367-48_3600.ODF to work")
}
