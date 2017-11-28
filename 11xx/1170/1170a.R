url <- "https://data.nodc.noaa.gov/argo/gadr/data/atlantic/2016/12/nodc_D1901204_167.nc"
file <- gsub("^.*/(.*)", "\\1", url)
if (0 == length(list.files(pattern=file)))
    download.file(url, file)

library(oce)
argo <- read.argo(file)
argoh <- handleFlags(argo)
ctd <- as.ctd(argoh, profile=1)
if (!interactive()) png("1170a.png")
plot(ctd)
if (!interactive()) dev.off()


