# test files files that broke tests in 2241b.R (until I fixed the code)
library(oce)
#source("~/git/oce/R/oce.R")
#source("~/git/oce/R/ctd.sbe.R")
file <- "/Users/kelley/data/arctic/beaufort//2008-hires/200830_Step1_data_convert/200830-001.cnv"
file <- "/Users/kelley/data/arctic/beaufort//2012-hires/201211_SBEDataProc_up_to_the_bin_average/201211-0030.cnv"
d1 <- read.ctd.sbe(file)
d2 <- read.oce(file, rename = FALSE)
d3 <- d2 |> rename("sbe")
# Some IOS Beaufort Sea files (from an intermediate stage in pipeline) lack salinity
addedSalinity <- FALSE
if (!"salinity" %in% names(d3[["data"]])) {
    d3 <- oceSetData(d3, "salinity",
        swSCTp(d3[["conductivity"]]/42.914, d3[["temperature"]], d3[["pressure"]]),
        unit = list(unit = expression(), scale = "PSS-78")
    )
    addedSalinity <- TRUE
}
ok1 <- identical(d1[["metadata"]], d3[["metadata"]])
ok2 <- identical(d1[["data"]], d3[["data"]])
cat(sprintf(
    "  %s: metadata %s, data %s %s\n",
    file,
    if (ok1) "ok" else "bad",
    if (ok2) "ok" else "bad",
    if (addedSalinity) " (after adding salinity column)" else ""
))
#summary(d1)
#summary(d3)
