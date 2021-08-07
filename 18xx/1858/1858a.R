# Not recognizing codes
# 1. 0x00 0x30 binary fixed attitude (Surveyor Table 35, page 150)
library(oce)
for (f in list.files(pattern="*.ENS")) {
    d <- read.adp.rdi(f, debug=1)
    cat(f, "\n  [[\"binaryFixedAttitudeHeaderRaw\"]]: ",
        paste(d[["binaryFixedAttitudeHeaderRaw"]],collapse=""), "\n", sep="")
}


