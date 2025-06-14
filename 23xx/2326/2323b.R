library(oce)
file <- "~/Dropbox/oce_secret_data/ad2cp/S101088A009_Nain_2022_0001_sub.ad2cp"
buf <- readBin(file, "raw", file.size(file))
#      START of 'altimeterRaw' part (at i0v=105)
# 2323a.R yields next:
#   getItemFromBuf: NB=1, NC=0, NBC=0, NP=34
#   i[1:34]:  153018,  459806,  766594, 1073382, 1380170, 1686958, 1993746, 2300534, 2607322, 2914110, ...,  7515930,  7822718,  8129506,  8436294,  8743082,  9049870,  9356658,  9663446,  9970234, 10277022#

i <- 153018 # first of 34 in this file
i0v <- 105
expect <- 2687
bad <- 2 * 2687
for (offset in seq(-50, 50)) {
    I <- i + i0v + offset
    value <- readBin(buf[I + 0:1], "int", n = 1, size = 2, signed = FALSE, endian = "little")
    if (offset == 0) {
        print(buf[I+0:10])
    }
    bin <- paste(ifelse(intToBits(value) == 01, "1", "0")[1:16], collapse = "")
    bin0 <- paste(ifelse(intToBits(as.integer(buf[I]))[8:1] == 01, "1", "0"), collapse="")
    bin1 <- paste(ifelse(intToBits(as.integer(buf[I+1]))[8:1] == 01, "1", "0"), collapse="")
    status <- if (value == expect) "expected value" else if (value == bad) "This is 2 times the expected value" else ""
    msg <- sprintf(
        "i:%d, i+i0v=%d, offset:%3d, byte1:0x%02x=%s, byte2: 0x%02x=%s, value:%5d %s\n", i, i + i0v, offset,
        as.integer(buf[i + i0v + offset + 0]),
        bin0,
        as.integer(buf[i + i0v + offset + 1]),
        bin1,
        value, status
    )
    cat(msg)
}
