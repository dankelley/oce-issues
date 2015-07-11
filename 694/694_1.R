library(oce)
#try(source("~/src/oce/R/rsk.R"))
#try(source("~/src/oce/R/ctd.R"))

## TESTING code -- to be place in oce/tests/rsk.R eventually.  There are 3
## options for read.rsk(): patm can be TRUE, FALSE, or a number; denote these
## as case I, II, and III.  Also, there are 2 options for as.ctd(): case a in
## which pressureAtmospheric not supplied (i.e. NA) or case b, in which it is
## not supplied. Thus we have cases I.a, I.b, II.a, II.b, III.a and III.b
tmp <- tempfile(fileext=".rsk")
R.utils::decompressFile("sample.rsk.gz", destname=tmp, ext="gz", FUN=gzfile, remove=FALSE)
## I.a
rsk <- read.rsk(tmp, patm=TRUE)
ctd <- as.ctd(rsk)
stopifnot(all.equal.numeric(ctd[["pressure"]], rsk[["pressure"]]))
## I.b
rsk <- read.rsk(tmp, patm=TRUE)
ctd <- as.ctd(rsk, pressureAtmospheric=1)
stopifnot(all.equal.numeric(ctd[["pressure"]], rsk[["pressure"]]-1))
## II.a
rsk <- read.rsk(tmp, patm=FALSE)
ctd <- as.ctd(rsk)
stopifnot(all.equal.numeric(ctd[["pressure"]], rsk[["pressure"]]-10.1325))
## II.b
rsk <- read.rsk(tmp, patm=FALSE)
ctd <- as.ctd(rsk, pressureAtmospheric=1)
stopifnot(all.equal.numeric(ctd[["pressure"]], rsk[["pressure"]]-10.1325-1))
## III.a
rsk <- read.rsk(tmp, patm=10)
ctd <- as.ctd(rsk)
stopifnot(all.equal.numeric(ctd[["pressure"]], rsk[["pressure"]]))
## III.b
rsk <- read.rsk(tmp, patm=10)
ctd <- as.ctd(rsk, pressureAtmospheric=1)
stopifnot(all.equal.numeric(ctd[["pressure"]], rsk[["pressure"]]-1))
### END of part that will go into oce/tests/rsk.R

## Back to defaults, and some plotting.
rsk <- read.rsk(tmp)
ctd <- as.ctd(rsk)
if (!interactive()) png("694_1_A.png")
plot(rsk)
if (!interactive()) dev.off()
if (!interactive()) png("694_1_B.png")
plot(ctd)
if (!interactive()) dev.off()
