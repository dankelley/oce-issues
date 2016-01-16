rm(list=ls())
library(oce)
try({
    ##> source("~/src/oce/R/argo.R")
    ##> source("~/src/oce/R/section.R")
    ##> source("~/src/oce/R/misc.R")
    ##> source("~/src/oce/R/ctd.R")
    argo <- read.argo("~/src/oce/create_data/argo/6900388_prof.nc")
    argo[['flags']]$pressure[,14]
    A <- handleFlags(argo, "NA")
    i <- 13 # profile 13 has good pressure from top to bottom
    df <- data.frame(f1=argo@metadata$flags$pressure[,i],
                     p1=argo@data$pressure[,i],
                     f2=A@metadata$flags$pressure[,i],
                     p2=A@data$pressure[,i])
    print(df)
    i <- 14 # profile 14 has bad pressure from top to bottom
    df <- data.frame(f1=argo@metadata$flags$pressure[,i],
                     p1=argo@data$pressure[,i],
                     f2=A@metadata$flags$pressure[,i],
                     p2=A@data$pressure[,i])
    print(df)
})

sec <- as.section(A)
sec[["station", 13]]
stopifnot(all(is.na(sec[["station", 14]][["pressure"]])))
if (!interactive()) png("892a.png")
plot(sec, "temperature")
if (!interactive()) dev.off()

