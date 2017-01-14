library(oce)
file <- "f34_20140625v7.2"
if (1 == length(list.files(pattern=file))) {
    d <- read.amsr(file)
    if (!interactive()) png("1043a.png")
    plot(d,xlim=c(-70,-20),ylim=c(40,60))
    if (!interactive()) dev.off()
}
