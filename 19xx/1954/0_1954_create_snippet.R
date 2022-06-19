# Truncate ad2cp file to hold just chunks 1 to 4.
f <- "S102791A002_Barrow_v2.ad2cp"

# Below is 'nav' as in R/adp.nortek.ad2cp.R near line 332, computed with
# do_ldc_ad2cp_in_file().  Note that the actual file pointer is 10 characters
# before index.  I test this in detail for the first 5 chunks, and then trim to
# hold just the first 4 of them.

# > str(DAN)
# List of 6
#  $ index               : int [1:1477] 10 4687 8473 8587 10065 10193 11671 11799
# 13277 13405 ...
#  $ length              : int [1:1477] 4667 3776 104 1468 118 1468 118 1468 118 1
# 468 ...
#  $ id                  : int [1:1477] 160 26 21 22 23 22 23 22 23 22 ...
#  $ checksumFailures    : int 0
#  $ earlyEOF            : int 0
#  $ twelve_byte_headered: int 0
# >                                   

# NOTE: 26=0xa1, 21=0x15, 22=0x16, 23=0x17
nb <- file.info(f)$size
b <- readBin(f, "raw", n=nb)
p <- 10-10
stopifnot(identical(as.raw(c(0xa5, 0x0a, 0xa0, 0x10)), b[p + 1:4]))
p <- 4687-10
stopifnot(identical(as.raw(c(0xa5, 0x0a, 0x1a, 0x10)), b[p + 1:4]))
p <- 8473-10
b[p + 1:4]
stopifnot(identical(as.raw(c(0xa5, 0x0a, 0x15, 0x10)), b[p + 1:4]))
p <- 8587-10
b[p + 1:4]
stopifnot(identical(as.raw(c(0xa5, 0x0a, 0x16, 0x10)), b[p + 1:4]))

if (TRUE) { # a bigger dataset with 2 altimeter profiles
    p <- 10065 - 10
    b[p + 1:4]
    stopifnot(identical(as.raw(c(0xa5, 0x0a, 0x17, 0x10)), b[p + 1:4]))
}
writeBin(b[1:p], "barrow_snippet.ad2cp", endian="little")

