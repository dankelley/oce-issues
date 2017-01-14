library(oce)
# source('~/src/oce/R/adp.rdi.R')
if (!interactive()) png("458b_%d.png", width=7, height=7, unit="in", res=150, pointsize=11)
for (file in rev(list.files(pattern="^T1_.*000$"))) {
    d <- read.adp.rdi(file, debug=0)
    plot(toEnu(d))
}
if (!interactive()) dev.off()

