debug <- 0
library(oce)
if (file.exists("~/git/oce/R/ctd.aml.R"))
    source("~/git/oce/R/ctd.aml.R")
files <- c(
    "Custom.export.026043_2021-07-21_17-36-45.txt",
    "ashleys_data/STANEK Option 2 026043_2021-07-25_18-22-27.csv",
    "clarks_data/025430_2022-02-23_16-18-35.csv",
    "clarks_data/025430_2022-02-23_16-18-35_qinsy_csv.csv",
    "clarks_data/025430_2022-02-23_16-18-35_seacast_csv.csv")
for (file in files) {
    cat("# ", file, "\n")
    t <- try({
        d <- read.ctd.aml(file, debug=debug)
    })
    if (inherits(t, "try-error")) {
        cat("* cannot parse\n\n")
    } else {
        cat("* can parse\n\n")
        #cat("* can parse; summary follows\n\n")
        #summary(d)
    }
}
