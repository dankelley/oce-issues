message("read file from data(adp) to see if any unknown codes\n")
library(oce)
f <- "/data/archive/sleiwex/2008/moorings/m09/adp/rdi_2615/raw/adp_rdi_2615.000"
if (file.exists(f)) {
    beam <- read.adp.rdi(f, debug=100)
    ldc0 <- oce:::do_ldc_rdi_in_file(f, from=1, to=0, by=1, 0L)
}

