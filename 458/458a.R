library(oce)
source('~/src/oce/R/adp.rdi.R')
for (file in list.files(pattern="^T1_.*000$")) {
    cat('about to read:', file, '\n')
    d <- read.adp.rdi(file, debug=4)
    cat(' ... read OK\n')
}

