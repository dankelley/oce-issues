library(oce)
options(width=120)
if (1 == length(list.files(pattern="JR302_001_align_ctm.cnv"))) {
    d <- read.ctd.sbe("JR302_001_align_ctm.cnv")
    summary(d)
} else {
    warning("942a.R uses private data for its testing")
}

## The issue report says that the conductivities are stored wrong,
## so print some for manual checking against the file contents.
print(head(d[['conductivity']]))

