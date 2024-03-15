library(oce)
file <- "~/git/oce/tests/testthat/local_data/adp_rdi"
if (file.exists(file)) {
    beam <- read.oce(file,
        from = as.POSIXct("2008-06-25 10:01:00", tz = "UTC"),
        to = as.POSIXct("2008-06-25 10:03:00", tz = "UTC", debug = 0)
    )
    summary(beam)
}
