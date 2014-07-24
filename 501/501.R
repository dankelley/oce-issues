if (!interactive()) png("501.png")
##SPACECRAFT_ID = "LANDSAlibrary(oce)
library(oce)
try({
    source("~/src/oce/R/landsat.R")
})

d <- read.landsat("~/google_drive/LE71910202005194ASN00",band="panchromatic", debug=3)
deband <- function(d)
{
    for (dd in names(d@data)) {
        message("dd:", dd)
        if (is.list(d@data[[dd]])) {
            message("list")
        } else {
            stop("can only deband lists now")
        }
    }
}
#d <- deband(d)
plot(d)

if (!interactive()) dev.off()

