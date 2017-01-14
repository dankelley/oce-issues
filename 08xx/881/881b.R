library(oce)

source('read_argo_mbari_20160219_dk.R') # not quite the same as Cara's; hers had flag problems


## curl http://www3.mbari.org/lobo/Data/FloatVizData/QC/5145HawaiiQC.txt > 5145HawaiiQC.txt
## curl http://www3.mbari.org/lobo/Data/FloatVizData/QC/6401HawaiiQC.txt > 6401HawaiiQC.txt

files <- c("5145HawaiiQC.txt", "6401HawaiiQC.txt")
for (file in files) {
    d <- read.argo.mbari(file)
    ds <- as.section(d)
    base <- gsub(".txt", "", file)

    if (!interactive()) png(paste("881b_", base, "_temperature.png", sep=""))
    plot(ds, xtype='time', which="temperature",ztype='image',
         ylim=c(0,400),zbreaks=seq(10,30,.2))
    mtext(file, side=3, line=0.25, adj=0)
    if (!interactive()) dev.off()

    if (!interactive()) png(paste("881b_", base, "_oxygen.png", sep=""))
    plot(ds, xtype='time', which="oxygen",ztype='image',
         ylim=c(0,400),zbreaks=seq(150,250,1))
    mtext(file, side=3, line=0.25, adj=0)
    if (!interactive()) dev.off()

    if (!interactive()) png(paste("881b_", base, "_nitrate.png", sep=""))
    plot(ds, xtype='time', which="nitrate",ztype='image',
         ylim=c(0,400),zbreaks=seq(0,20,1))
    mtext(file, side=3, line=0.25, adj=0)
    if (!interactive()) dev.off()

}
