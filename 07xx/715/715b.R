rm(list=ls())
if (1 == length(list.files(pattern="CTD_DGR2006001_9_1_DN.ODF"))) {
    library(oce)
    source("define_ODF_header.R")
    source("read_ODF.R")
    if (!interactive()) pdf("715b.pdf")

    ## TEST 1: CTD file in Barrow Strait
    ODF1 <- read_odf("CTD_DGR2006001_9_1_DN.ODF")
    odf1 <- ODF2oce(ODF1)
    plot(odf1, span=1000)
    summary(odf1)

    ## TEST 2: moored CTD file in Barrow Strait
    ODF2 <- read_odf("MCTD_DGR2005001_1576_0862_1800.ODF")
    odf2 <- ODF2oce(ODF2)
    plot(subset(odf2, time > as.POSIXct("2005-11-01", tz="UTC")))
    summary(odf2)

    ## TEST 3: another ODF file, used in early tests
    odf3 <- read.oce("CTD_BCD2010666_01_01_DN.ODF")
    summary(odf3)
    plot(odf3)

    ## TEST 4: another ODF file, used in early tests
    odf4 <- read.oce("MVCTD_HUD2008004_021_001_DN.ODF")
    summary(odf4)
    plot(odf4, span=1000)
    if (!interactive()) dev.off()
} else {
    warning("715b.R: only the developers can do tests here, since they have some private files")
}
