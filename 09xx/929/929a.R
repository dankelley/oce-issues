library(oce)
for (file in list.files(pattern=".cnv")) {
    d <- read.oce(file)
    summary(d)
    plot(d)
}
