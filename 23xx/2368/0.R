# Demonstrate getting first bottom-track data chunk
library(oce)
file <- "/Users/kelley/Downloads/S102791A003_Barrow_2022_0001_sub.ad2cp"
buf <- readBin(file, "raw", n=file.size(file))
d <- oce:::do_ldc_ad2cp_in_file(file, from = 1L, to = 1e9, by = 1L, debug = 0)

i <- which(d$id == 0x17)[1]
bt <- buf[seq(1+d$start[i], length=d$headerLength[i] + d$dataLength[i])]
bt # notice the 4 repeats of [64 46 f1 ff], velocities
v <- 1e-5 * readBin(bt[89:92], "integer", size=4, n=1, endian="little")
v
