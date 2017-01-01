library(oce)
library(testthat)
source("read.adp.rdi.text.R") # defines read.adp.rdi.text()
debug <- 0                             # set to 5 or so for full debugging info

if (0 == length(ls(pattern="^a$"))) {
    message("reading 'apd0', 'atxt', 'bpd0' and 'btxt'")
    apd0 <- read.oce("A_test2.pd0", debug=debug)
    bpd0 <- read.oce("B_test2.pd0", debug=debug)
    atxt <- read.adp.rdi.text("A_test2.txt")
    btxt <- read.adp.rdi.text("B_test2.txt")
} else {
    message("using cached values of 'apd0', 'atxt', 'bpd0', and 'btxt'")
}

## some scalars
for (item in c("time", "heading", "pitch", "roll")) {
    cat("apd0[[", item, "]] = ", paste(head(apd0[[item]]), collapse=" "), "\n", sep="")
    cat("atxt[[", item, "]] = ", paste(head(atxt[[item]]), collapse=" "), "\n", sep="")
    cat("bpd0[[", item, "]] = ", paste(head(bpd0[[item]]), collapse=" "), "\n", sep="")
    cat("btxt[[", item, "]] = ", paste(head(btxt[[item]]), collapse=" "), "\n", sep="")
}

## velocity

## first profile, first 3 bins, all 4 beams
apd0[["v"]][1, 1:3, 1:4]
atxt[["v"]][1, 1:3, 1:4]
bpd0[["v"]][1, 1:3, 1:4]
btxt[["v"]][1, 1:3, 1:4]

## second profile, first 3 bins, all 4 beams
apd0[["v"]][2, 1:3, 1:4]
atxt[["v"]][2, 1:3, 1:4]
bpd0[["v"]][2, 1:3, 1:4]
btxt[["v"]][2, 1:3, 1:4]

## third profile, first 3 bins, all 4 beams
apd0[["v"]][3, 1:3, 1:4]
atxt[["v"]][3, 1:3, 1:4]
bpd0[["v"]][3, 1:3, 1:4]
btxt[["v"]][3, 1:3, 1:4]

