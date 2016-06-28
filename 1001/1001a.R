library(oce)
toread <- c("042.cnv","041.cnv","040.cnv")
ctds <- vector("list", length(toread))
for ( i in 1:length(toread))
    ctds[i] <- ctdDecimate(ctdTrim(read.ctd.sbe(file.path(toread[i]))),p=1)
sec1 <- as.section(ctds)
summary(sec1)
if (!interactive())
    png("1001a.png", type="cairo")
plot(sec1,
     which="temperature",
     #which=c("temperature","salinity2","oxygen2","map"),
     xtype='distance',ztype='image', showStations=TRUE)
if (!interactive())
    dev.off()
