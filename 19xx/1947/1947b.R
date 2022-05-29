library(oce)
file <- list.files(pattern=".cnv.gz")[2]
source("~/git/oce/R/ctd.sbe.R");d <- read.ctd.sbe(file, debug=0)
cat("   d[[\"date\"]]=", format(d[["date"]]), "\n", sep="")
cat("   first entry in time column: ", format(d[["time"]][1]), "\n\n\n", sep="")

f <- "/Library/Frameworks/R.framework/Versions/4.2/Resources/library/oce/extdata/d201211_0011.cnv"
source("~/git/oce/R/ctd.sbe.R");d <- read.ctd.sbe(f, debug=0)
