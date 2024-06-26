library(oce)
ctd <- read.bremen("msm27_012.ctd")
ladcp <- read.bremen("msm27_012.ladcp")

if (!interactive()) png("659a_1.png")
plot(ctd, span=5000)
if (!interactive()) dev.off()
if (!interactive()) png("659a_2.png")
plot(ladcp)
if (!interactive()) dev.off()
ctd
ladcp
summary(ctd)
summary(ladcp)

