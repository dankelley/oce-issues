library(oce)
rsk <- read.rsk('file.rsk')
str(rsk@metadata)
ctd <- as.ctd(rsk)
profiles <- ctdFindProfiles(ctd)
str(ctd@metadata)
if (!interactive()) png("642b-%02d.png")
for (i in 1:length(profiles)) {
    plot(profiles[[i]])
}
if (!interactive()) dev.off()
