# Issue 594: negative length vector error in read.adp.rdi

## 594A.R

Sources the local version of `adp.rdi.R`, which has wrapped the offending line 92 in an `abs()` to get rid of the negative, e.g.

    numberOfCells <- abs(readBin(FLD[10], "integer", n=1, size=1)) # WN

Reading the data seems ok after that.

The question is, why is that coming back as a negative number? Also, what does the `WN` comment signify?
