library(oce)
if (1 == length(list.files(pattern="CTD_DGR2009001_1_1_DN.ODF"))) {
    d <- read.oce("CTD_DGR2009001_1_1_DN.ODF")
    plot(d)
    plot(as.ctd(d))
    plotProfile(d, xtype='conductivity')
    plotProfile(as.ctd(d), xtype='conductivity')
} else {
    cat("cannot run the 1185a.R test because of missing data file\n")
}
