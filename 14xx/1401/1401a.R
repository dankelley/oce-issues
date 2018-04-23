library(oce)
options(warn=1)
f <- '/users/kelley/Dropbox/oce-working-notes/tests/adp-rdi/winriver_vesselmounted_1200kHz/DATA_20080701123035_000r.000'
if (file.exists(f)) {
    d <- read.adp.rdi(f, debug=100)
    ldc <- oce:::do_ldc_rdi_in_file(f, from=1, to=0, by=1, 0L)
}

## I don't see a pattern to the timing, but the fact that
## there are only 3 chunk lengths suggests this is not an error.
print(table(diff(ldc$ensembleStart)))
d <- diff(ldc$ensembleStart)

## Plot some data, to see if there's a pattern
if (!interactive())
    png("1401.png", width=7, height=7, unit="in", res=150, pointsize=9)
par(mfrow=c(4, 1), mar=c(3, 3, 1, 1), mgp=c(2, 0.7, 0))
plot(1:200, d[1:200], type='s', col='lightgray', ylab="diff(ensembleStart)")
points(1:200, d[1:200], pch=20, cex=0.7, col=2)

plot(201:400, d[201:400], type='s', col='lightgray', ylab="diff(ensembleStart)")
points(201:400, d[201:400], pch=20, cex=0.7, col=2)

plot(401:600, d[401:600], type='s', col='lightgray', ylab="diff(ensembleStart)")
points(401:600, d[401:600], pch=20, cex=0.7, col=2)

plot(601:800, d[601:800], type='s', col='lightgray', ylab="diff(ensembleStart)")
points(601:800, d[601:800], pch=20, cex=0.7, col=2)
dev.off()

df <- data.frame(d=d, buf3=as.numeric(head(ldc$outbuf[ldc$ensembleStart+3], -1)))
print(table(df))
stem(df$d)
stem(df$buf3)
cat("df$buf3 values: ", paste(unique(df$buf3), collapse=" "), "\n")
stem(subset(df, buf3==3)$d)
stem(subset(df, buf3==4)$d)

## experiment on the 7f7f sequences
cat(f, "\n")
for (i in 1:10) {
    offsets <- readBin(ldc$outbuf[ldc$ensembleStart[i]+seq(6, 2*
    cat(sprintf("i=%3d ensemble_len=%5d num_data_types=%2d diff_start=%5d\n",
                i,
                readBin(ldc$outbuf[ldc$ensembleStart[i]+2:3], "integer", n=1, size=2),
                readBin(ldc$outbuf[ldc$ensembleStart[i]+5], "integer", n=1, size=1),
                ldc$ensembleStart[i+1]-ldc$ensembleStart[i]))
}


