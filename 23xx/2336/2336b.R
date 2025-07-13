library(oce)
files <- c("~/Dropbox/oce_secret_data/01.rsk", "~/Dropbox/oce_secret_data/01b.rsk")
for (file in files) {
    if (file.exists(file)) {
        d <- read.oce(file, debug = 0)
        d <- read.oce(file, debug = 1)
    }
}
