library(oce)
if (!interactive()) {
    png("2230a.png",
        unit = "in",
        width = 4.55, height = 7,
        pointsize = 16, res = 100
    )
}
file <- download.amsr(Sys.Date(), type = "rt")
amsr <- read.amsr(file)
asc <- subset(amsr, pass == "ascending")
des <- subset(amsr, pass == "descending")
com <- composite(asc, des)
par(mfrow = c(3, 1))
plot(asc, col = oceColorsTurbo)
mtext("pass=\"ascending\"", cex = par("cex"))
plot(des, col = oceColorsTurbo)
mtext("pass=\"descending\"", cex = par("cex"))
plot(com, col = oceColorsTurbo)
mtext("composite", cex = par("cex"))
if (!interactive()) {
    dev.off()
}
