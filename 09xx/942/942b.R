library(oce)
options(width=120)
if (1 == length(list.files(pattern="S262-023-CTD.cnv"))) {
    d <- read.ctd.sbe("S262-023-CTD.cnv")
    summary(d)
} else {
    warning("942b.R uses private data for its testing")
}

## The issue report says that the conductivities are stored wrong,
## so print some for manual checking against the file contents.
print(head(d[['conductivity']]))
