library(oce)
f <- "~/Dropbox/quipp1.ad2cp"
if (file.exists(f)) {
    d <- read.ad2cp(f, from=1, to=1000, by=1)#, debug=10)
    summary(d)
    if (!interactive()) png("1219e1.png", unit="in", res=150, width=7, height=7, pointsize=10)
    plot(d)
    if (!interactive()) dev.off()
    if (!interactive()) png("1219e2.png", unit="in", res=150, width=7, height=7, pointsize=10)
    plot(d, which="amplitude")
    if (!interactive()) dev.off()
}

