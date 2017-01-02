## This code must be run with old oce, i.e. the `develop` branch before the
## 1093-inspired code entered it. That is why the resultant .rda is stored in
## git, and why the whole code here will be blocked out, once the .rda is
## saved.

if (FALSE) {
    library(oce)
    file <- "/data/archive/sleiwex/2008/moorings/m09/adp/rdi_2615/raw/adp_rdi_2615.000"
    adp01 <- read.oce(file, from=10, to=20)
    save(adp01, file="1093a.rdi")
} 
