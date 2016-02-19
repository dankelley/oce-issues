library(oce)
try(source("~/src/oce/R/section.R"))
try(source("~/src/oce/R/argo.R"))
try(source("~/src/oce/R/ctd.R"))

source('read_argo_mbari_20160219_dk.R') # not quite the same as Cara's; hers had flag problems


## curl http://www3.mbari.org/lobo/Data/FloatVizData/QC/5145HawaiiQC.txt > 5145HawaiiQC.txt
## curl http://www3.mbari.org/lobo/Data/FloatVizData/QC/6401HawaiiQC.txt > 6401HawaiiQC.txt

files <- c("5145HawaiiQC.txt", "6401HawaiiQC.txt")
for (file in files[2]) {
    cat("***", file, "\n")
                                        #    d <- read.argo.mbari(file)
    ds <- as.section(d)

    cat("** temperature plot...\n")
    plot(ds, xtype='time', which="temperature",ztype='image',
         ylim=c(0,400),zbreaks=seq(10,30,.2))
    cat("... temperature plot OKAY\n")

    if (FALSE){
        cat("** oxygen plot...\n")
        plot(ds, xtype='time', which="oxygen",ztype='image',
             ylim=c(0,400),zbreaks=seq(150,250,1))
        cat("... oxygen plot OKAY\n")

        cat("** nitrate plot...\n")
        plot(ds, xtype='time', which="nitrate",ztype='image',
             ylim=c(0,400),zbreaks=seq(0,20,1))
        cat("... nitrate plot OKAY\n")
    }
}
