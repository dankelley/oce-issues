library(oce)
source("~/git/oce/R/coastline.R")
source("~/git/oce/R/map.R")
library(testthat)
data(coastlineWorld)

options(oceDebug=3)

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

clongitude <- -63.2
clatitude <- 46.5
span <- 350

for (i in 1:2) {
    projection <- if (i == 1) NULL else "+proj=aea +lon_0=-63"

    ## TEST 1: fillable data
    lab <- paste("fillable", if(i==1) "/linear " else "/map ", sep="")
    plot(peiFillable, projection=projection, clatitude=clatitude, clongitude=clongitude, span=span)
    mtext("expect: gray/black polygon", col="magenta", side=3, adj=1, line=0)
    mtext(lab, col=2, side=3, line=-1, adj=1)
    mtext("type='polygon' ", col=2, side=3, line=-2, adj=1)

    plot(peiFillable, type="l", projection=projection, clatitude=clatitude, clongitude=clongitude, span=span)
    mtext("expect: black lines", col="magenta", side=3, adj=1, line=0)
    mtext(lab, col=2, side=3, line=-1, adj=1)
    mtext("type='l' ", col=2, side=3, line=-2, adj=1)

    plot(peiFillable, type="p", col="red", projection=projection, clatitude=clatitude, clongitude=clongitude, span=span)
    mtext("expect: red circles", col="magenta", side=3, adj=1, line=0)
    mtext(lab, col=2, side=3, line=-1, adj=1)
    mtext("type='p' ", col=2, side=3, line=-2, adj=1)

    plot(peiFillable, type="o", col="blue", pch=20, projection=projection, clatitude=clatitude, clongitude=clongitude, span=span)
    mtext("expect: blue circles+lines", col="magenta", side=3, adj=1, line=0)
    mtext(lab, col=2, side=3, line=-1, adj=1)
    mtext("type='o' ", col=2, side=3, line=-2, adj=1)

    ## TEST 2: unfillable data
    lab <- paste("unfillable", if(i==1) "/linear " else "/map ", sep="")
    plot(peiUnfillable, debug=4, border="red", col="lightblue", projection=projection, clatitude=clatitude, clongitude=clongitude, span=span)
    mtext("expect: blue/red polygon", col="magenta", side=3, adj=1, line=0)
    mtext(lab, col=2, side=3, line=-1, adj=1)
    mtext("type='polygon' ", col=2, side=3, line=-2, adj=1)

    plot(peiUnfillable, type="l", projection=projection, clatitude=clatitude, clongitude=clongitude, span=span)
    mtext("expect: lines w/ gap", col="magenta", side=3, adj=1, line=0)
    mtext(lab, col=2, side=3, line=-1, adj=1)
    mtext("type='l' ", col=2, side=3, line=-2, adj=1)

    plot(peiUnfillable, type="p", col="red", projection=projection, clatitude=clatitude, clongitude=clongitude, span=span)
    mtext("expect: red circles", col="magenta", side=3, adj=1, line=0)
    mtext(lab, col=2, side=3, line=-1, adj=1)
    mtext("type='p' ", col=2, side=3, line=-2, adj=1)

    plot(peiUnfillable, type="o", col="blue", pch=20, projection=projection, clatitude=clatitude, clongitude=clongitude, span=span)
    mtext("expect: blue lines w/ gap & dots", col="magenta", side=3, adj=1, line=0)
    mtext(lab, col=2, side=3, line=-1, adj=1)
    mtext("type='o' ", col=2, side=3, line=-2, adj=1)
}

if (!interactive()) dev.off()

