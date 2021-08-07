# Recognize code 0x00 0x30 binary fixed attitude (Surveyor Table 35, page 150),
# to address github issue #1858.
message(getwd())

library(oce)
for (f in list.files(pattern="*.ENS")) {
    d <- read.adp.rdi(f, debug=0)
    cat(f, "\n  [[\"binaryFixedAttitudeHeaderRaw\"]]: ",
        paste(d[["binaryFixedAttitudeHeaderRaw"]],collapse=""), "\n", sep="")
}


