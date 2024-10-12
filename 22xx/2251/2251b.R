library(oce)
#source("~/git/oce/R/oce.R")
#source("~/git/oce/R/ctd.sbe.R")
dir <- "~/data/arctic/beaufort/"
nfiles <- 0L
nfilesBad <- 0
if (dir.exists(dir)) {
    subdirs <- list.dirs(dir)
    for (subdir in subdirs) {
        files <- list.files(subdir, "*.cnv", full.names = TRUE)
        if (length(files) > 0) {
            cat(subdir, "\n")
            for (file in files) {
                nfiles <- nfiles + 1L
                d1 <- read.ctd.sbe(file)
                d2 <- try(read.oce(file, rename = FALSE))
                if (inherits(d2, "try-error")) {
                    cat("read.oce(\"", file, "\") failed\n")
                    nfilesBad <- nfilesBad + 1
                } else {
                    d3 <- d2 |> rename("sbe")
                    # Some IOS Beaufort Sea files (from an intermediate stage in pipeline) lack salinity
                    addedSalinity <- FALSE
                    if (!"salinity" %in% names(d3[["data"]])) {
                        d3 <- oceSetData(d3, "salinity",
                            swSCTp(d3[["conductivity"]] / 42.914, d3[["temperature"]], d3[["pressure"]]),
                            unit = list(unit = expression(), scale = "PSS-78")
                        )
                        addedSalinity <- TRUE
                    }
                    ok1 <- identical(d1[["metadata"]], d3[["metadata"]])
                    ok2 <- identical(d1[["data"]], d3[["data"]])
                    cat(sprintf(
                        "    %4d %s: metadata %s, data %s %s\n",
                        nfiles,
                        gsub(".*/", "", file),
                        if (ok1) "ok" else "bad",
                        if (ok2) "ok" else "bad",
                        if (addedSalinity) "(after adding salinity column)" else ""
                    ))
                    if (!ok1 || !ok2) {
                        nfilesBad <- nfilesBad + 1
                        cat("\n --- d1 summary ---\n")
                        summary(d1)
                        cat("\n --- d3 summary ---\n")
                        summary(d3)
                        stop("mismatch (remove this when all are ok)")
                    }
                }
            }
        }
    }
    cat(sprintf("Of %d files examined; %d (%f %%) had rename() problems\n", nfiles, nfilesBad, 100 * nfilesBad/nfiles))
}
