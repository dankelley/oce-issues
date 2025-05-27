library(oce)
f <- "~/Downloads/S104098A002_2297d.ad2cp"
if (file.exists(f)) {
    TOC <- read.adp.ad2cp(f, TOC = TRUE)
    print(TOC)
}
