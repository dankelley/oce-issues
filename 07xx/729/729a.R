if (length(list.files(pattern="MADCPS_hud2013021_1841_3367-48_3600.ODF"))) {
    library(oce)
    library(testthat)
    d <- read_odf("MADCPS_hud2013021_1841_3367-48_3600.ODF")
    dd <- ODF2oce(d)
    expect_equal(names(dd@data), c("u", "v", "w", "error", "a", "g", "time"))
    nd <- length(names(dd@data))
    for (i in 1:nd) {
        if (is.numeric(dd@data[[i]])) {
            ## check on 101 because percent-good goes from 0 to 100%
            expect_less_than(diff(range(dd@data[[i]], na.rm=TRUE)), 101)
        }
    }
} else {
    message("729a.R requires a file named MADCPS_hud2013021_1841_3367-48_3600.ODF to work")
}
