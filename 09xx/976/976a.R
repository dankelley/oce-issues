library(oce)
options(warn=1, width=120)
rsks <- list.files("~/Dropbox/oce-working-notes/rsk", "*.rsk", full.name=TRUE)
for (i in seq_along(rsks)) {
    cat("\n\n")
    cat(paste(rep("#", 100), collapse=""), "\n")
    cat("# rsk[", i, "] = ", rsks[i], "\n", sep="")
    rsk <- read.rsk(rsks[i], debug=99)
    cat("\n")
    summary(rsk)
    try({
        ctd <- as.ctd(rsk)
        cat("\n")
        summary(ctd)
    })
}

