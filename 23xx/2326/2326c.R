library(oce)
file <- "~/Dropbox/oce_secret_data/ad2cp/S101088A009_Nain_2022_0001_sub.ad2cp"
buf <- readBin(file, "raw", file.size(file))

# # 2323a.R yields next, where it :
#   getItemFromBuf: NB=1, NC=0, NBC=0, NP=34
#   i[1:34]:  153018,  459806, ETC
is <- c(
    153018, 459806, 766594, 1073382, 1380170, 1686958, 1993746, 2300534, 2607322, 2914110, 3220898, 3527686,
    3834474, 4141262, 4448050, 4754838, 5061626, 5368414, 5675202, 5981990, 6288778, 6595566, 6902354,
    7209142, 7515930, 7822718, 8129506, 8436294, 8743082, 9049870, 9356658, 9663446, 9970234, 10277022
)

i0v <- 105 # pointer to where the altimeterRaw data start
cat(file, "\n")
cat("The following gives a pointer then bytes before/after the pointer (with '*' at the pointer)\n")
for (i in is) {
    cat(sprintf("%9d: ", i + i0v), sep = "")
    for (offset in seq(-14, 14)) {
        I <- i + i0v + offset
        if (offset == 0) {
            cat(" * ", buf[I], sep = "")
        } else {
            cat(" ", buf[I], sep = "")
        }
    }
    cat("\n")
}
cat("Notes:\n")
cat(" 1. hex fe 14 00 00 = ", readBin(as.raw(c(0xfe, 0x14, 0x00, 0x00)), "integer", size = 4, n = 1), " decimal (=2x expected)\n")
cat(" 2. hex f0 00       =  ", readBin(as.raw(c(0xf0, 0x00)), "integer", size = 2, n = 1), " decimal (=expected, for 0.024 m altimeter cells size)\n")
