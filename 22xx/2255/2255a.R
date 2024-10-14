library(oce)
file <- "ctd.cnv"
file <- "d201211_0011.cnv" # name 19 fails pattern decoding (two '=')
file <- file(file, encoding = "latin1")
lines <- readLines(file)
nameLines <- lines[grep("^# name [0-9]+ =", lines)]
names <- gsub("^#.* = ([^:]*):.*$", "\\1", nameLines)
nameLines
units <- unname(sapply(
    nameLines,
    \(l) {
        if (grepl("\\[", l)) {
            gsub("^#.*\\[(.*)\\].*$", "\\1", l)
        } else {
            ""
        }
    }
))
#names(units) <- names
print(units)
print(nameLines[23])
nameLines[10]
source("~/git/oce/R/units.R")
u <- inferUnits(units, dictionary="~/git/oce/inst/extdata/units_default.csv", FALSE)
sapply(u, \(U) U$unit)
#inferUnits("deg C", dictionary="~/git/oce/inst/extdata/units_default.csv")
#inferUnits("deg c", dictionary="~/git/oce/inst/extdata/units_default.csv")
