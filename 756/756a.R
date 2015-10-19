options(warn=3)
if (length(list.files(pattern="CTD_HUD2014030_163_1_DN.ODF"))) {
    library(ODF)                           # DK version, patched to work in his locale; not open-source
    library(oce)
    try(source("~/src/oce/R/oce.R"))
    try(source("~/src/oce/R/odf.R"))
    d <- read_odf("CTD_HUD2014030_163_1_DN.ODF")
    dd <- as.oce(d)
    str(dd)
} else {
    message("729a.R requires a file named CTD_HUD2014030_163_1_DN.ODF to work; DK can send to CR if needed")
}
