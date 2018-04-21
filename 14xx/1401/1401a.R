library(oce)
options(warn=1)
f <- '~/Dropbox/oce-working-notes/tests/adp-rdi/winriver_vesselmounted_1200kHz/DATA_20080701123035_000r.000'
if (file.exists(f)) {
    d <- read.adp.rdi(f, debug=100) # debug > 10 yields LDC for examination
}

## I don't see a pattern to the timing, but the fact that
## there are only 3 chunk lengths suggests this is not an error.
print(table(diff(ldc0$ensembleStart)))
d <- diff(ldc0$ensembleStart)

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

df <- data.frame(d=d, buf3=as.numeric(head(ldc0$outbuf[ldc0$ensembleStart+3], -1)))
print(table(df))
stem(df$d)
stem(df$buf3)
cat("df$buf3 values: ", paste(unique(df$buf3), collapse=" "), "\n")
stem(subset(df, buf3==3)$d)
stem(subset(df, buf3==4)$d)

