library(oce)
if (1 == length(list.files(path="~", pattern="amsr1.gz"))) {
    a1 <- read.amsr("~/amsr1.gz")
    a2 <- read.amsr("~/amsr2.gz")
    a3 <- read.amsr("~/amsr3.gz")
    ## on home machine --
    ##    user  system elapsed 
    ##   0.370   0.016   0.386 
    system.time({
        a <- composite(a1, a2, a3)
    })
    if (!interactive()) png("1056a_%d.png")
    par(mfrow=c(2,2))
    plot(a1, xlim=c(-70, -50), ylim=c(20,60))
    plot(a2, xlim=c(-70, -50), ylim=c(20,60))
    plot(a3, xlim=c(-70, -50), ylim=c(20,60))
    plot(a, xlim=c(-70, -50), ylim=c(20,60))
    if (!interactive()) dev.off()
} else {
    message("1056a.R requires private data to work (AMSR data on 3 consequtive days)")
}
