library(oce)

f2 <- "S102791A002_Barrow_v2_avgd.ad2cp"

# Detect headers by 3 byte match (to see if read.adp.ad2cp() is just haywire)
n <- file.info(f2)$size
b <- readBin(f2, "raw", n)
check3 <- sapply(seq_len(n-2),
    function(i)
        b[i]==as.raw(0xa5) && b[i+1]==as.raw(0x0a) && b[i+3]==as.raw(0x10))
cat("Crude check suggests chunks start at cindex=", paste(which(check3)-1, collapse=" "), "\n")

d2 <- read.adp.ad2cp(f2, debug=3)
#d2 <- read.adp.ad2cp(f2, ignoreChecksums=TRUE, debug=3)

