if (!interactive()) png("448.png", width=7, height=4, unit="in", res=150, pointsize=9)
library(oce)

if (length(list.files(pattern="*.ODF"))) {
    d <- read.oce('MCTD_DGR2008001_1685_0770_1800.ODF')
} else {
    d <- read.oce('ftp://starfish.mar.dfo-mpo.gc.ca/pub/ocean/seaice/Data_Lancaster/MCTD/2008/MCTD_DGR2008001_1685_0770_1800.ODF')
}

summary(d)
oce.plot.ts(d[['time']], d[['temperature']])
if (!interactive()) dev.off()
