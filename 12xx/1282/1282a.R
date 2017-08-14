library(oce)
source("~/git/oce/R/coastline.R")
library(testthat)
data(coastlineWorld)

if (!interactive()) png("1282a_%d.png")

## test data: coarse PEI coastline
peilon <- c(-63.6645, -62.9393, -62.01208, -62.50391, -62.87433,
            -64.1427999999999, -64.39261, -64.01486, -63.6645)

peilat <- c(46.55001, 46.41587, 46.4431400000001, 46.03339, 45.96818,
            46.39265, 46.72747, 47.03601, 46.55001)
peiFillable<- as.coastline(peilon, peilat, fillable=TRUE)
expect_true(peiFillable[["fillable"]])
peiUnfillable <- as.coastline(tail(peilon, -1), tail(peilat, -1))
expect_false(peiUnfillable[["fillable"]])

par(mfrow=c(2,2))

## TEST 1: fillable data
plot(peiFillable)
mtext("expect: polygon", col="magenta", font=2, side=3, adj=1, line=0)

plot(peiFillable, type="l")
mtext("expect: gray lines", col="magenta", font=2, side=3, adj=1, line=0)

plot(peiFillable, type="p", col="red", pch=2)
mtext("expect: red triangles", col="magenta", font=2, side=3, adj=1, line=0)

plot(peiFillable, type="o", col="red",pch=20)
mtext("expect: red lines and pch=20 points", col="magenta", side=3, adj=1, line=0)

## TEST 2: unfillable data
plot(peiUnfillable, debug=4)
mtext("expect: polygon", col="magenta", font=2, side=3, adj=1, line=0)

plot(peiUnfillable, type="l")
mtext("expect: gray lines", col="magenta", font=2, side=3, adj=1, line=0)

plot(peiUnfillable, type="p")
mtext("expect: red points", col="magenta", font=2, side=3, adj=1, line=0)

plot(peiUnfillable, type="o", col="red", pch=20)
mtext("expect: red lines and pch=20 points", col="magenta", font=2, side=3, adj=1, line=0)

if (!interactive()) dev.off()

