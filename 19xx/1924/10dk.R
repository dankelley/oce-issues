library(oce)
options(oceEOS="unesco") # so can test density with a file that lacks metadata
source("~/git/oce/R/ctd.aml.R")
files <- c(list.files(path="clarks_data", "*.txt", full=TRUE),
    list.files(".", "*.txt", full=TRUE))
files <- "clarks_data/Custom 025430_2022-02-23_16-18-35_export_allfields_noheader.txt"
if (!interactive()) png("10dk_%02d.png")
for (file in files) {
    firstLine <- readLines(file, warn=FALSE)[1]
    if (grepl("Date", firstLine)) {
        cat("# ", file, "\n")
        d <- read.ctd.aml(file)
        d@data$conductivity <- d@data$conductivity - 0.001 # TESTING
        #print(summary(d))
        if ("Salinity..PSU." %in% names(d@data)) {
            print(names(d@data))
            try({
                plot(d[["pressure"]], d[["salinity"]] - d[["Salinity..PSU."]])
                mtext(file, cex=0.9)
            })
        }
        if ("Density..kg.m.3." %in% names(d@data)) {
            try({
                plot(d[["pressure"]], d[["density"]] - d[["Density..kg.m.3."]])
                mtext(file, cex=0.9)
            })
        }
    }
}
if (!interactive()) dev.off()
