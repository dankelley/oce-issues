library(oce)
f <- "/data/archive/sleiwex/2008/moorings/m09/adp/rdi_2615/raw/adp_rdi_2615.000"
if (file.exists(f)) {
    beam <- read.adp.rdi(f, debug=0)
    ldc <- oce:::do_ldc_rdi_in_file(f, from=1, to=0, by=1, 0L)
}
if (!interactive()) png("1401b.png")
plot(beam)
if (!interactive()) dev.off()

## experiment on the 7f7f sequences
for (i in 1:10) {
    cat("i=", i,
        "len=", readBin(ldc$outbuf[ldc$ensembleStart[i]+2:3], "integer", n=1, size=2),
        "diff(ensembleStart)=", ldc$ensembleStart[i+1]-ldc$ensembleStart[i], "\n")
}


