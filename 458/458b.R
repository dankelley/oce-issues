library(oce)
for (file in rev(list.files(pattern="^T1_.*000$"))) {
    cat('about to read:', file, '\n')
    d <- read.oce(file, debug=6)
    cat(' ... read OK\n')
}

