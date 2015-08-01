library(oce)
if (!length(list.files(pattern="test.sbe"))) {
    columns <- list(scan=1, pressure=2, temperature=3, temperature2=4,
                    conductivity=5, conductivity2=6, oxygen=7, ph=8, oxygen2=9,
                    fluorescence=10, parirradiance=11, oxygen3=12, oxygen4=13,
                    salinity=14, salinity2=15, sigmat=16, sigmat2=17,
                    oxygen3=18)
    if (!interactive()) png("710.png")
    d <- read.ctd.sbe("710.sbe")
    par(mfrow=c(1,2))
    plotProfile(d)
    dd <- read.ctd.sbe("710.sbe", columns=columns)
    plotProfile(dd)
    title("EXPECT: identical panels", font=2, col="magenta")
    if (!interactive()) dev.off()
} else {
    message("710.R needs a datafile named 710.sbe to run")
}
