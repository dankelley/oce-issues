library(oce)
f <- "~/Downloads/S104098A002_2297d.ad2cp"
if (file.exists(f)) {
    d <- read.adp.ad2cp(f, dataType = 0x16)
    summary(d)
}
