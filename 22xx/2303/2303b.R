library(oce)
f <- "~/Downloads/Suisun_test.ad2cp"
if (file.exists(f)) {
    TOC <- read.adp.ad2cp(f, TOC = TRUE, plan = 2)
    print(TOC)
    dataTypes <- TOC$dataType
    for (dataType in "echosounder") {
        message("trying to read dataType \"", dataType, "\"")
        d <- read.adp.ad2cp(f, dataType = dataType, debug = 1)
        message("    ... got ", length(d[["time"]]), " time entries")
        summary(d)
    }
}
