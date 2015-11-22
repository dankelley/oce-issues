## Test file recognition
message("DK to CR: this restricts to files ending .000; I'm not sure that's right")
library(oce)
path <- "~/Dropbox/oce-RDI-testfiles"
file000 <- list.files(path=path, pattern=".000$", recursive=TRUE)
for (file in file000) {
    filename <- paste(path, file, sep="/")
    message(filename)
    message("    ", oceMagic(filename))
}
