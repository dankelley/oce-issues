library(oce)
d1 <- read.oce("M39_5_phys_oce.tab.tsv") # in this github repository
summary(d1)

d2 <- read.oce("Schneider-etal_2015.tab.tsv") # a (large) private file
summary(d2)

d2ctd <- as.ctd(d2)
profiles <- ctdFindProfiles(d2ctd, distinct="location")
if (!interactive()) png("1075a_%02d.png")
for (profile in profiles)
    plot(profile)
if (!interactive()) dev.off()

