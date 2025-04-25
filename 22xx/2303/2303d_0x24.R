library(oce)
options("oceDebugAD2CP" = TRUE) # to get 'DAN' exported
f <- "~/Downloads/Suisun_test.ad2cp"
if (file.exists(f)) {
    TOC <- read.adp.ad2cp(f, TOC = TRUE)
    print(TOC)
    x <- read.adp.ad2cp(f, dataType = "echosounderRawTx")
    print(str(x))
    #if (!interactive()) {
    #    png("oce2303d_0x24_%d.png",
    #        unit = "in",
    #        width = 7, height = 4, res = 400, pointsize = 10
    #    )
    #}
    #plot(burst0)
    #if (!interactive()) {
    #    dev.off()
    #}
}
