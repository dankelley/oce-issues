library(oce)
library(testthat)
options(warn=1, width=120)
rsks <- list.files("~/Dropbox/oce-working-notes/rsk","*.rsk",full.names=TRUE)
for (i in seq_along(rsks)) {
    cat("\n\n")
    cat(paste(rep("=", 100), collapse=""), "\n")
    cat("== i:", i, ", file: ", rsks[i], "\n", sep="")
    cat(paste(rep("=", 100), collapse=""), "\n")
    rsk <- read.oce(rsks[i])
    summary(rsk)
    try({
        ctd <- as.ctd(rsk)
        summary(ctd)
        ## check that all rsk metadata got transferred correctly (even if they
        ## may not mean anything specific in the ctd context)
        cat("\nCheck whether metadata transfer correctly from rsk to ctd...\n")
        for (item in names(rsk@metadata)) {
            if (item != "units" && item != "flags") {
                expect_equal(rsk@metadata[[item]], ctd@metadata[[item]],
                             label=paste("checking metadata$", item, sep=""),
                             expected.label=rsk@metadata[[item]],
                             info=paste("failed while checking metadata$", item, sep="")) 
                cat("    ", item, "is OK\n")
            } else {
                cat("    ", item, "not checked, because it will always differ (owing to salinity)\n")
            }
        }
        cat("\nCheck whether data transfer correctly from rsk to ctd...\n")
        for (item in names(rsk@data)) {
            if (item != "pressure") {
                expect_equal(rsk@data[[item]], ctd@data[[item]],
                             label=paste("checking data$", item, sep=""),
                             expected.label=rsk@data[[item]],
                             info=paste("failed while checking data$", item, sep="")) 
                cat("    ", item, "is OK\n")
            } else {
                cat("    ", item, "not checked, because it will always differ (owing to definition)\n")
            }
        }
 


    })
}

