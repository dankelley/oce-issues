library(oce)

source('read_argo_mbari_20160219_dk.R') # not quite the same as Cara's; hers had flag problems

file <- "5145HawaiiQC.txt"
d <- read.argo.mbari(file)
ds <- as.section(d)

if (!interactive()) png("881a_1.png")
## works ok
plot(ds, xtype='time', which="temperature",ztype='image',
     ylim=c(0,400),zbreaks=seq(10,30,.2))
if (!interactive()) dev.off()

## works ok
if (!interactive()) png("881a_2.png")
plot(ds, xtype='time', which="oxygen",ztype='image',
         ylim=c(0,400),zbreaks=seq(150,250,1))
if (!interactive()) dev.off()
if (!interactive()) png("881a_2.png")

## DK found (by running the plot below, using traceback() etc) that
## the problem is that station 198 (where the error occurs) has no nitrate
## data. Let's check
n <- length(ds@data$station)
for (i in 1:n) cat("profile",i, if(any(is.finite(d[['nitrate']][,i]))) "has" else "lacks", "nitrate data\n")

## works ok in updated oce ('develop' branch, commit )
if (!interactive()) png("881a_3.png")
plot(ds, xtype='time', which="nitrate",ztype='image',
     ylim=c(0,400),zbreaks=seq(0,20,1))
if (!interactive()) dev.off()

