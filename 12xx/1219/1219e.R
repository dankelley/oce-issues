library(oce)
f <- "~/Dropbox/quipp1.ad2cp"
if (file.exists(f)) {
    d <- read.ad2cp(f, from=1, to=100, by=1, debug=10)
    summary(d)
    if (!interactive()) png("1219e.png")
    plot(d)
    if (!interactive()) dev.off()
}

