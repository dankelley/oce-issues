library(oce)
if (!interactive()) png("715c_%02d.png")
for (file in list.files(pattern="*.ODF")) {
    d <- read.oce(file)
    summary(d)
    plot(d)
}
if (!interactive()) dev.off()

