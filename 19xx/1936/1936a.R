options(warn=1)
library(oce)
file <- "ad2cp_01.ad2cp"
d <- read.adp.ad2cp(file)
cat("read.adp.ad2cp() reads p=", paste(d[["pressure"]], collapse=" "),"\n")

# Now read "manually" from an rda temporarily made at
# https://github.com/dankelley/oce/blob/212b0d21ffa4ce528f1c10fcad02dd55be48f4bc/R/adp.nortek.R#L816
load("TEST.rda")
B <- TEST$buf[TEST$pointer4[1:4]+21]
fac <- 0.001
p1 <- fac*readBin(B, "integer", size=4, endian="little")
cat("Using readBin(), I get p1=", p1, "\n")
b1 <- as.integer(B[1])
b2 <- as.integer(B[2])
b3 <- as.integer(B[3])
b4 <- as.integer(B[4])
p2 <- 0.001 * (b1 + 256*b2 + 256^2*b3 + 256^3*b4)
cat("From b1=",b1," b2=",b2," b3=",b3," b4=",b4,", I assemble p2=",p2,"\n")
