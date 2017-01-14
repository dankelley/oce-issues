message("499.R only works if two private .rda files are present")
library(oce)
## try({
##     source('~/src/oce/R/ctd.R')
##     source('~/src/oce/R/sw.R')
## })
load("ctd071.rda")                     # ctd
swDynamicHeight(ctd)
load("knorr_section_2002.rda")         # sec
stations <- sec[["station"]]
for (stn in seq_along(stations)) {     # stn 7 was problematic
    cat("station:", stn, "dynHeight:", swDynamicHeight(stations[[stn]]), "m\n")
}
## now try on a section
swDynamicHeight(sec)
